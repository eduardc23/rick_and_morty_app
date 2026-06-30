import '../../error/failures.dart';

/// Política centralizada de reintentos automáticos para los providers
/// de Riverpod.
///
/// Riverpod 3 reintenta automáticamente cualquier provider cuyo `build()`
/// falle, usando backoff exponencial por defecto (hasta 10 veces). Ese
/// comportamiento por defecto no distingue el *tipo* de error, así que un
/// 404 de negocio se reintenta igual que un fallo de red.
///
/// Esta clase aplica el criterio correcto según el [Failure] lanzado:
///
/// - [NetworkFailure]: fallo de conectividad, es transitorio -> se reintenta.
/// - [ServerFailure] con código 5xx (o sin código conocido): probable error
///   temporal del servidor -> se reintenta.
/// - [ServerFailure] con código 4xx: error de cliente (request mal formada,
///   no autorizado, etc.), reintentar no lo va a arreglar -> NO se reintenta.
/// - [NotFoundFailure]: resultado de negocio esperado (ej. una búsqueda sin
///   resultados) -> NUNCA se reintenta.
/// - [RateLimitFailure]: ya tiene su propio mecanismo de espera
///   (`retryAfter`) gestionado manualmente en los notifiers -> NO se
///   reintenta aquí, para no duplicar el tiempo de espera.
/// - [UnknownFailure] o cualquier error no mapeado explícitamente: se asume
///   que puede ser un bug o un error no controlado, así que NO se reintenta
///   por defecto (evita ocultar errores de programación detrás de
///   reintentos silenciosos).
abstract final class AppRetryPolicy {
  /// Número máximo de reintentos antes de rendirse y propagar el error.
  static const int _maxAttempts = 3;

  /// Delay base del backoff exponencial (300ms, 600ms, 1.2s, ...).
  static const Duration _baseDelay = Duration(milliseconds: 300);

  /// Decide si reintentar y con qué delay.
  ///
  /// Devuelve `null` para detener los reintentos y dejar que el error se
  /// propague al estado del provider (`AsyncError`).
  static Duration? resolve(int retryCount, Object error) {
    if (retryCount >= _maxAttempts) return null;

    return switch (error) {
      NetworkFailure() => _backoff(retryCount),

      ServerFailure(statusCode: final code) when code == null || code >= 500 =>
        _backoff(retryCount),

      ServerFailure() => null, // 4xx -> error de cliente, no se reintenta

      NotFoundFailure() => null,

      RateLimitFailure() => null,

      UnknownFailure() => null,

      // Cualquier error no controlado explícitamente (excepciones de
      // parsing, errores de programación, etc.) tampoco se reintenta.
      _ => null,
    };
  }

  static Duration _backoff(int retryCount) {
    return _baseDelay * (1 << retryCount);
  }
}

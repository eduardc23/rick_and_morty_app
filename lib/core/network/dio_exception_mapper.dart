import 'dart:io';

import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../utils/app_durations.dart';

/// Traduce las excepciones lanzadas por Dio ([DioException]) a las
/// excepciones propias del dominio de la aplicación (ej. [NetworkException],
/// [ServerException], [NotFoundException], [RateLimitException]).
///
/// Centraliza el manejo de errores de red para que todos los
/// `RemoteDataSource` de la app traduzcan los errores de forma
/// consistente, evitando duplicar esta lógica en cada feature.
class DioExceptionMapper {
  /// Punto de entrada principal: recibe la [DioException] capturada en el
  /// data source y retorna la excepción de dominio correspondiente.
  Exception map(DioException e) {
    if (_isTimeout(e)) return NetworkException();
    if (_isConnectionError(e)) return NetworkException();

    if (e.type == DioExceptionType.badResponse) {
      return _mapBadResponse(e);
    }

    // Caso especial: si el error original ya viene envuelto como una
    // RateLimitException (por ejemplo, lanzada por un interceptor),
    // se reutiliza directamente en vez de reconstruirla.
    if (e.error is RateLimitException) {
      return e.error as RateLimitException;
    }

    return ServerException(message: e.message);
  }

  /// Determina si el error corresponde a un timeout de conexión,
  /// de envío o de recepción de datos.
  bool _isTimeout(DioException e) =>
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;

  /// Determina si el error corresponde a un problema de conectividad,
  /// ya sea reportado directamente por Dio o envuelto en un
  /// [SocketException] (ej. sin conexión a internet).
  bool _isConnectionError(DioException e) =>
      e.type == DioExceptionType.connectionError || e.error is SocketException;

  /// Mapea los errores que sí obtuvieron una respuesta del servidor
  /// (status code disponible) a su excepción de dominio correspondiente.
  Exception _mapBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 404) return NotFoundException();

    if (statusCode == 429) {
      final retryAfterHeader = e.response?.headers.value('retry-after');
      return RateLimitException(
        retryAfter: _resolveBlockDuration(retryAfterHeader),
      );
    }

    return ServerException(message: e.message, statusCode: statusCode);
  }

  /// Calcula la duración de bloqueo a partir del header `retry-after`
  /// devuelto por el servidor en un error 429.
  ///
  /// Si el header no está presente o no es un número de segundos válido,
  /// se usa [AppDurations.defaultRateLimitBlock] como valor por defecto.
  Duration _resolveBlockDuration(String? retryAfterHeader) {
    if (retryAfterHeader == null) return AppDurations.defaultRateLimitBlock;

    final seconds = int.tryParse(retryAfterHeader);
    return seconds != null
        ? Duration(seconds: seconds)
        : AppDurations.defaultRateLimitBlock;
  }
}

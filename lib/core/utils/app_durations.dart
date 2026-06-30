abstract class AppDurations {

  static const searchDebounce = Duration(milliseconds: 500);

  /// Tiempo de bloqueo por defecto aplicado cuando la API responde con
  /// un error 429 (Too Many Requests) y no se puede determinar la
  /// duración exacta a partir del header `retry-after`.
  static const defaultRateLimitBlock = Duration(seconds: 5);
}

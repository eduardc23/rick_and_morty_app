import 'package:flutter/cupertino.dart';

/// Controlador de scroll personalizado para implementar paginación infinita.
///
/// Extiende [ScrollController] y notifica mediante [onThresholdReached]
/// cuando el usuario se acerca al final de la lista, permitiendo cargar
/// más datos antes de llegar al límite absoluto del scroll.
class PaginationScrollController extends ScrollController {
  PaginationScrollController({
    required this.onThresholdReached,
    this.threshold = 200,
  });

  /// Callback que se ejecuta cuando el scroll alcanza el [threshold]
  /// definido, normalmente usado para disparar la carga de la siguiente
  /// página de resultados.
  final VoidCallback onThresholdReached;

  /// Distancia en píxeles (desde el final del scroll) a partir de la cual
  /// se considera que se alcanzó el límite y se debe notificar mediante
  /// [onThresholdReached].
  ///
  /// Por defecto es 200, es decir, cuando falten 200px o menos para
  /// llegar al final del scroll, se ejecutará el callback.
  final double threshold;

  /// Registra el listener interno [_onScroll] que monitorea el scroll.
  ///
  /// Debe llamarse explícitamente después de crear la instancia
  /// (por ejemplo, en el `initState` del widget que lo use).
  void init() => addListener(_onScroll);

  /// Verifica en cada evento de scroll si la cantidad de contenido
  /// restante por debajo de la posición actual ([position.extentAfter])
  /// es menor al [threshold] definido.
  ///
  /// Si la condición se cumple, ejecuta [onThresholdReached].
  ///
  /// Se valida [hasClients] primero para evitar errores cuando el
  /// controller aún no está asociado a ningún [Scrollable].
  void _onScroll() {
    if (!hasClients) return;
    if (position.extentAfter < threshold) onThresholdReached();
  }

  /// Elimina el listener interno y libera los recursos del controller
  /// para evitar fugas de memoria (memory leaks).
  @override
  void dispose() {
    removeListener(_onScroll);
    super.dispose();
  }
}

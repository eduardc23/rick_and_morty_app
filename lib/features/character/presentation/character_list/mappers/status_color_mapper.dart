import 'package:flutter/material.dart';

import '../../../domain/entities/enums/character_status.dart';

/// Define el contrato para obtener el color asociado a un [CharacterStatus].
///
/// Se utiliza el patrón **Strategy** para desacoplar la lógica de mapeo de
/// colores del widget que los renderiza. De esta forma, diferentes
/// implementaciones pueden definir su propia estrategia de colores sin
/// modificar los widgets consumidores.
abstract class StatusColorMapper {
  Color map(CharacterStatus status, ColorScheme colors);
}


/// Asigna un color del [ColorScheme] según el estado del personaje:
/// - Alive -> [ColorScheme.primary].
/// - Dead -> [ColorScheme.error].
/// - Unknown -> [ColorScheme.outline].
class DefaultStatusColorMapper implements StatusColorMapper {
  const DefaultStatusColorMapper();

  @override
  Color map(CharacterStatus status, ColorScheme colors) {
    if (status.isAlive) return colors.primary;
    if (status.isDead) return colors.error;
    return colors.outline;
  }
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';

/// Entidad de dominio que representa un personaje de Rick and Morty.
/// 
/// Esta clase es inmutable y define la estructura principal de un personaje
/// utilizada en la lógica de negocio y la interfaz de usuario.
@freezed
abstract class Character with _$Character {
  const Character._();

  const factory Character({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String originName,
    required String locationName,
    required String image,
    required List<String> episodes,
  }) = _Character;

  /// Devuelve una descripción corta del personaje.
  String get summary =>
      '$name es un personaje de especie $species con estado $status y género $gender';
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums/character_gender.dart';
import 'enums/character_species.dart';
import 'enums/character_status.dart';
import 'value_objects/character_id.dart';

part 'character.freezed.dart';

/// Entidad de dominio que representa un personaje de Rick and Morty.
/// 
/// Esta clase es inmutable y define la estructura principal de un personaje
/// utilizada en la lógica de negocio y la interfaz de usuario.
@freezed
abstract class Character with _$Character {
  const Character._();

  const factory Character({
    /// Identificador único del personaje.
    required CharacterId id,
    /// Nombre del personaje.
    required String name,
    /// Estado del personaje (Alive, Dead o unknown).
    required CharacterStatus status,
    /// Especie del personaje.
    required CharacterSpecies species,
    /// Tipo o subespecie del personaje.
    required String type,
    /// Género del personaje (Female, Male, Genderless o unknown).
    required CharacterGender gender,
    /// Nombre del lugar de origen del personaje.
    required String originName,
    /// Nombre de la última ubicación conocida del personaje.
    required String locationName,
    /// URL de la imagen del personaje (300x300).
    required String image,
    /// Lista de URLs de los episodios en los que aparece el personaje.
    required List<String> episodes,
  }) = _Character;

  /// Devuelve una descripción corta del personaje.
  String get summary =>
      '$name es un personaje de especie $species con estado $status y género $gender';

}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

/// Modelo de datos (DTO) para el personaje recibido de la API.
/// 
/// Incluye campos adicionales y estructuras anidadas (como [LocationModel])
/// que son propias del contrato con la API externa.
@freezed
abstract class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    /// ID único del personaje.
    required int id,
    /// Nombre del personaje.
    required String name,
    /// Estado (Alive, Dead, unknown).
    required String status,
    /// Especie.
    required String species,
    /// Tipo.
    required String type,
    /// Género.
    required String gender,
    /// Objeto con información sobre el origen.
    required LocationModel origin,
    /// Objeto con información sobre la última ubicación conocida.
    required LocationModel location,
    /// URL de la imagen.
    required String image,
    /// Lista de episodios en los que aparece.
    required List<String> episode,
    /// URL del recurso del personaje.
    required String url,
    /// Fecha de creación del personaje en la base de datos.
    required String created,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}

/// Modelo para representar la información de ubicación dentro de un personaje.
@freezed
abstract class LocationModel with _$LocationModel {
  const factory LocationModel({
    /// Nombre de la ubicación.
    required String name,
    /// URL del recurso de la ubicación.
    required String url,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}

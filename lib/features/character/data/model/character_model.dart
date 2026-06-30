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
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required LocationModel origin,
    required LocationModel location,
    required String image,
    required List<String> episode,
    required String url,
    required String created,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);
}

/// Modelo para representar la información de ubicación dentro de un personaje.
@freezed
abstract class LocationModel with _$LocationModel {
  const factory LocationModel({
    required String name,
    required String url,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}

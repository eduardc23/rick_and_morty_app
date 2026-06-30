import 'package:freezed_annotation/freezed_annotation.dart';
import 'character_model.dart';
import 'info_model.dart';

part 'character_response_model.freezed.dart';
part 'character_response_model.g.dart';

/// Modelo que representa la respuesta completa de la API al listar personajes.
@freezed
abstract class CharacterResponseModel with _$CharacterResponseModel {
  const factory CharacterResponseModel({
    /// Metadatos de paginación.
    required InfoModel info,
    /// Lista de personajes devueltos.
    required List<CharacterModel> results,
  }) = _CharacterResponseModel;

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) => _$CharacterResponseModelFromJson(json);
}

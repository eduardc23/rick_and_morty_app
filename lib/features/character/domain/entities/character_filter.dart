import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_filter.freezed.dart';

/// Filtros disponibles para la búsqueda de personajes.
///
/// Permite filtrar por nombre
/// las opciones permitidas por la API de Rick and Morty.
@freezed
abstract class CharacterFilter with _$CharacterFilter {
  const factory CharacterFilter({
    /// Filtro por nombre del personaje.
    String? name,
  }) = _CharacterFilter;
}

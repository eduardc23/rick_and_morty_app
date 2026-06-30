import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_filter.freezed.dart';

/// Filtros disponibles para la búsqueda de personajes.
///
/// Permite filtrar por nombre
@freezed
abstract class CharacterFilter with _$CharacterFilter {
  const factory CharacterFilter({String? name}) = _CharacterFilter;
}

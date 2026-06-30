import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_filter.freezed.dart';

@freezed
abstract class CharacterFilter with _$CharacterFilter {
  const factory CharacterFilter({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) = _CharacterFilter;
}

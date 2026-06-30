import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/character.dart';
import '../../domain/entities/pagination_info.dart';

part 'character_list_state.freezed.dart';

@freezed
abstract class CharacterListState with _$CharacterListState {
  const CharacterListState._();
  const factory CharacterListState({
    required PaginatedResponse<Character> response,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    DateTime? blockedUntil,
  }) = _CharacterListState;

  bool get isRateLimited =>
      blockedUntil != null && DateTime.now().isBefore(blockedUntil!);
}

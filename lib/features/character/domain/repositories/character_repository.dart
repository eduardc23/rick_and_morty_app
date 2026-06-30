import 'package:rick_and_morty_app/features/character/domain/entities/character.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/pagination_info.dart';

abstract class CharacterRepository {
  Future<PaginatedResponse<Character>> getCharacters({
    int page = 1,
    String? name,
  });
}

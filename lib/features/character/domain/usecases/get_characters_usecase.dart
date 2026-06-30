import 'package:rick_and_morty_app/features/character/domain/entities/character.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/pagination_info.dart';
import 'package:rick_and_morty_app/features/character/domain/repositories/character_repository.dart';

class GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCase(this.repository);

  Future<PaginatedResponse<Character>> call({int page = 1, String? name}) {
    return repository.getCharacters(page: page, name: name);
  }
}

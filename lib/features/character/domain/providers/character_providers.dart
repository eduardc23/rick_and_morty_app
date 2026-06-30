import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rick_and_morty_app/features/character/data/providers/character_data_providers.dart';
import 'package:rick_and_morty_app/features/character/domain/usecases/get_characters_usecase.dart';

part 'character_providers.g.dart';

@riverpod
GetCharactersUseCase getCharactersUseCase(Ref ref) {
  final repository = ref.watch(getCharacterRepositoryProvider);
  return GetCharactersUseCase(repository);
}

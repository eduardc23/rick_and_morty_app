import 'package:rick_and_morty_app/features/character/data/model/character_response_model.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterResponseModel> getCharacters({int? page, String? name});
}

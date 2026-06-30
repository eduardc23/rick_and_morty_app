import 'package:rick_and_morty_app/features/character/data/model/character_model.dart';
import 'package:rick_and_morty_app/features/character/data/model/character_response_model.dart';
import 'package:rick_and_morty_app/features/character/data/model/info_model.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/character.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/pagination_info.dart';

/// Clase encargada de transformar Modelos (Data) en Entidades (Domain).
/// 
/// Esta separación permite que la capa de dominio no dependa de la estructura
/// de los datos externos o de la base de datos.
class CharacterMapper {
  /// Convierte un [CharacterModel] en una entidad [Character].
  static Character fromModel(CharacterModel model) {
    return Character(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      type: model.type,
      gender: model.gender,
      originName: model.origin.name,
      locationName: model.location.name,
      image: model.image,
      episodes: model.episode,
    );
  }

  /// Convierte un [InfoModel] en una entidad [PaginationInfo].
  static PaginationInfo infoFromModel(InfoModel model) {
    return PaginationInfo(
      count: model.count,
      pages: model.pages,
      next: model.next,
      prev: model.prev,
    );
  }

  /// Convierte una respuesta completa [CharacterResponseModel] en un [PaginatedResponse] de dominio.
  static PaginatedResponse<Character> responseFromModel(CharacterResponseModel model) {
    return PaginatedResponse<Character>(
      info: infoFromModel(model.info),
      results: model.results.map((e) => fromModel(e)).toList(),
    );
  }
}

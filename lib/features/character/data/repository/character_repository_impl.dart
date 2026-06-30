import 'package:rick_and_morty_app/core/error/failures.dart';
import 'package:rick_and_morty_app/features/character/data/datasource/character_remote_datasource.dart';
import 'package:rick_and_morty_app/features/character/data/mapper/character_mapper.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/character.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/pagination_info.dart';
import 'package:rick_and_morty_app/features/character/domain/repositories/character_repository.dart';

import '../../../../core/error/exceptions.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<PaginatedResponse<Character>> getCharacters({
    int page = 1,
    String? name,
  }) async {
    try {
      final responseModel = await remoteDataSource.getCharacters(
        page: page,
        name: name,
      );
      return CharacterMapper.responseFromModel(responseModel);
    } on ServerException catch (e) {
      throw ServerFailure(statusCode: e.statusCode, message: e.message);
    } on NetworkException catch (_) {
      throw NetworkFailure();
    } on NotFoundException catch (_) {
      throw NotFoundFailure();
    } on RateLimitException catch (e) {
      throw RateLimitFailure(retryAfter: e.retryAfter);
    } catch (_) {
      throw UnknownFailure();
    }
  }
}

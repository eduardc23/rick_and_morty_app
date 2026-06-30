import 'package:rick_and_morty_app/core/network/dio_exception_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rick_and_morty_app/core/providers/network_providers.dart';
import 'package:rick_and_morty_app/features/character/data/datasource/character_api_client.dart';
import 'package:rick_and_morty_app/features/character/data/datasource/character_remote_datasource.dart';
import 'package:rick_and_morty_app/features/character/data/datasource/character_remote_datasource_impl.dart';
import 'package:rick_and_morty_app/features/character/data/repository/character_repository_impl.dart';
import 'package:rick_and_morty_app/features/character/domain/repositories/character_repository.dart';

part 'character_data_providers.g.dart';

@riverpod
CharacterRemoteDataSource getCharacterRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiClient = CharacterApiClient(dio);
  final exceptionMapper = DioExceptionMapper();
  return CharacterRemoteDataSourceImpl(apiClient, exceptionMapper);
}

@riverpod
CharacterRepository getCharacterRepository(Ref ref) {
  final remoteDataSource = ref.watch(getCharacterRemoteDataSourceProvider);
  return CharacterRepositoryImpl(remoteDataSource);
}

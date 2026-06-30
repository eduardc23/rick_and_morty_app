import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_exception_mapper.dart';
import '../model/character_response_model.dart';
import 'character_api_client.dart';
import 'character_remote_datasource.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  CharacterRemoteDataSourceImpl(this.apiClient, this.exceptionMapper);

  final CharacterApiClient apiClient;
  final DioExceptionMapper exceptionMapper;

  @override
  Future<CharacterResponseModel> getCharacters({int? page, String? name}) async {
    try {
      return await apiClient.getCharacters(page: page, name: name);
    } on DioException catch (e) {
      throw exceptionMapper.map(e);
    } on SocketException {
      throw NetworkException();
    }
  }
}
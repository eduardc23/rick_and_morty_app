import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../model/character_response_model.dart';
import 'character_api_client.dart';
import 'character_remote_datasource.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final CharacterApiClient apiClient;

  CharacterRemoteDataSourceImpl(this.apiClient);

  @override
  Future<CharacterResponseModel> getCharacters({
    int? page,
    String? name,
  }) async {
    try {
      return await apiClient.getCharacters(page: page, name: name);
    } on DioException catch (e) {
      throw _mapDioExceptionToException(e);
    } on SocketException {
      throw NetworkException();
    }
  }

  Exception _mapDioExceptionToException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkException();
    }

    if (e.type == DioExceptionType.connectionError ||
        e.error is SocketException) {
      return NetworkException();
    }

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 404) {
        return NotFoundException();
      }

      if (statusCode == 429) {
        final retryAfterHeader = e.response?.headers.value('retry-after');
        final blockDuration = _resolveBlockDuration(retryAfterHeader);

        return RateLimitException(retryAfter: blockDuration);
      }

      return ServerException(message: e.message, statusCode: statusCode);
    }

    if (e.error is RateLimitException) {
      return e.error as RateLimitException;
    }

    return ServerException(message: e.message);
  }
}

Duration _resolveBlockDuration(String? retryAfterHeader) {
  if (retryAfterHeader == null) return const Duration(seconds: 5);

  final seconds = int.tryParse(retryAfterHeader);
  if (seconds != null) return Duration(seconds: seconds);

  return const Duration(seconds: 5);
}

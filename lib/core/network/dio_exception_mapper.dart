import 'dart:io';

import 'package:dio/dio.dart';

import '../error/exceptions.dart';

class DioExceptionMapper {
  Exception map(DioException e) {
    if (_isTimeout(e)) return NetworkException();
    if (_isConnectionError(e)) return NetworkException();

    if (e.type == DioExceptionType.badResponse) {
      return _mapBadResponse(e);
    }

    if (e.error is RateLimitException) {
      return e.error as RateLimitException;
    }

    return ServerException(message: e.message);
  }

  bool _isTimeout(DioException e) =>
      e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout;

  bool _isConnectionError(DioException e) =>
      e.type == DioExceptionType.connectionError || e.error is SocketException;

  Exception _mapBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 404) return NotFoundException();

    if (statusCode == 429) {
      final retryAfterHeader = e.response?.headers.value('retry-after');
      return RateLimitException(retryAfter: _resolveBlockDuration(retryAfterHeader));
    }

    return ServerException(message: e.message, statusCode: statusCode);
  }

  Duration _resolveBlockDuration(String? retryAfterHeader) {
    if (retryAfterHeader == null) return const Duration(seconds: 5);

    final seconds = int.tryParse(retryAfterHeader);
    return seconds != null ? Duration(seconds: seconds) : const Duration(seconds: 5);
  }
}
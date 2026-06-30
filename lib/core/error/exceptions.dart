sealed class AppException implements Exception {
  const AppException();
}

class NetworkException extends AppException {
  const NetworkException();
}

class ServerException extends AppException {
  final String? message;
  final int? statusCode;

  const ServerException({this.message, this.statusCode});
}

class NotFoundException extends AppException {
  const NotFoundException();
}

class RateLimitException extends AppException {
  final Duration retryAfter;
  const RateLimitException({required this.retryAfter});
}

class UnknownException extends AppException {
  const UnknownException();
}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class ServerFailure extends Failure {
  final String? message;
  final int? statusCode;

  const ServerFailure({this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

class RateLimitFailure extends Failure {
  final Duration retryAfter;

  const RateLimitFailure({required this.retryAfter});
}

class UnknownFailure extends Failure {
  const UnknownFailure();
}

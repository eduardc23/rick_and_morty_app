import 'failures.dart';

extension FailureMessageX on Object {
  String toUserMessage() {
    final error = this;

    if (error is Failure) {
      switch (error) {
        case ServerFailure():
          return 'Server error${error.statusCode != null ? ' (${error.statusCode})' : ''}. Please try again later.';
        case NetworkFailure():
          return 'No internet connection. Check your network and try again.';
        case NotFoundFailure():
          return 'No results found.';
        case RateLimitFailure():
          return 'Too many requests. Please wait ${error.retryAfter.inSeconds} seconds';
        case UnknownFailure():
          return 'An unexpected error occurred.';
      }
    }

    return 'An unexpected error occurred';
  }
}
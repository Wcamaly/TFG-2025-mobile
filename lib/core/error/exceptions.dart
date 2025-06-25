class NetworkException implements Exception {
  final String? message;
  NetworkException([this.message]);
}

class TimeoutException extends NetworkException {
  TimeoutException([String? message]) : super(message);
}

class BadRequestException extends NetworkException {
  BadRequestException([String? message]) : super(message);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([String? message]) : super(message);
}

class ForbiddenException extends NetworkException {
  ForbiddenException([String? message]) : super(message);
}

class NotFoundException extends NetworkException {
  NotFoundException([String? message]) : super(message);
}

class ServerException extends NetworkException {
  ServerException([String? message]) : super(message);
}

class NoInternetException extends NetworkException {
  NoInternetException([String? message]) : super(message);
}

class UnknownException extends NetworkException {
  UnknownException([String? message]) : super(message);
}

abstract class RacegoException implements Exception {
  RacegoException(this.errorMessage);
  String errorMessage;
}

class InternetException extends RacegoException {
  InternetException(String errorMessage) : super(errorMessage);
}

class ServerException extends RacegoException {
  ServerException(String errorMessage) : super(errorMessage);
}

class AuthException extends RacegoException {
  AuthException(String errorMessage) : super(errorMessage);
}

class DataException extends RacegoException {
  DataException(String errorMessage) : super(errorMessage);
}

class UnknownException extends RacegoException {
  UnknownException(String errorMessage, [this._details, this._errorType])
      : super(errorMessage);
  final String? _details;
  final String? _errorType;

  String get details => _details ?? '';
  String get errorType => _errorType ?? '';
}

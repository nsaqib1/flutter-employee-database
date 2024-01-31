abstract class AppException {}

class ServerRequestFailedException implements AppException {
  final String message;

  ServerRequestFailedException({required this.message});
}

class JsonSerializationException implements AppException {}

class NetworkConnectionException implements AppException {}

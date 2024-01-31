class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final dynamic response;
  final String errorMessage;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.response,
    this.errorMessage = "",
  });
}

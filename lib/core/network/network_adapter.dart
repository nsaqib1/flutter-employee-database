import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:task_assignment/core/error/exceptions.dart';
import 'package:task_assignment/core/network/network_response.dart';

abstract class NetworkAdapter {
  Future<NetworkResponse> getRequest(String url);
  Future<NetworkResponse> postRequest(String url, Map<String, dynamic> json);
  Future<NetworkResponse> putRequest(String url, Map<String, dynamic> json);
  Future<NetworkResponse> deleteRequest(String url);
}

class NetworkAdapterImpl implements NetworkAdapter {
  @override
  Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
      );

      return _generateNetworkResponse(response);
    } on SocketException {
      throw NetworkConnectionException();
    }
  }

  @override
  Future<NetworkResponse> postRequest(String url, Map<String, dynamic> json) async {
    try {
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(json),
        headers: {'Content-type': 'application/json'},
      );

      return _generateNetworkResponse(response);
    } on SocketException {
      throw NetworkConnectionException();
    }
  }

  @override
  Future<NetworkResponse> putRequest(String url, Map<String, dynamic> json) async {
    try {
      final Response response = await put(
        Uri.parse(url),
        body: jsonEncode(json),
        headers: {'Content-type': 'application/json'},
      );

      return _generateNetworkResponse(response);
    } on SocketException {
      throw NetworkConnectionException();
    }
  }

  @override
  Future<NetworkResponse> deleteRequest(String url) async {
    try {
      final Response response = await delete(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
      );

      return _generateNetworkResponse(response);
    } on SocketException {
      throw NetworkConnectionException();
    }
  }

  NetworkResponse _generateNetworkResponse(Response response) {
    if (response.statusCode == 200) {
      final NetworkResponse successResponse = NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        response: response.body,
      );

      return successResponse;
    } else if (response.statusCode == 429) {
      final NetworkResponse successResponse = NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        response: response.body,
        errorMessage: "Server Returned an Error: Too Many Request",
      );

      return successResponse;
    } else {
      try {
        final NetworkResponse failedResponse = NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          response: response.body,
          errorMessage: jsonDecode(response.body)["message"] ?? "Network request failed!",
        );
        return failedResponse;
      } catch (e) {
        final NetworkResponse failedResponse = NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          response: response.body,
          errorMessage: "Network request failed!",
        );
        return failedResponse;
      }
    }
  }
}

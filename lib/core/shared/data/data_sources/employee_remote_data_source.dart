import 'dart:convert';
import '../../../network/urls.dart';
import '../../../error/exceptions.dart';
import '../../../network/network_adapter.dart';
import '../models/employee_model.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<EmployeeModel>> getAllEmployees();
  Future<EmployeeModel> getSingleEmployee(int id);
  Future<EmployeeModel> createNewEmployee(EmployeeModel employee);
  Future<EmployeeModel> updateEmployee(EmployeeModel employee);
  Future<int> deleteEmployee(int id);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final NetworkAdapter _networkAdapter;
  EmployeeRemoteDataSourceImpl({
    required NetworkAdapter networkAdapter,
  }) : _networkAdapter = networkAdapter;

  @override
  Future<List<EmployeeModel>> getAllEmployees() async {
    final networkResponse = await _networkAdapter.getRequest(Urls.getAllEmployees);

    if (networkResponse.isSuccess) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(networkResponse.response);
        List<EmployeeModel> list = (jsonData['data'] as List).map((employeeData) => EmployeeModel.fromJson(employeeData)).toList();

        return list;
      } catch (e) {
        throw JsonSerializationException();
      }
    } else {
      throw ServerRequestFailedException(message: networkResponse.errorMessage);
    }
  }

  @override
  Future<EmployeeModel> getSingleEmployee(int id) async {
    final networkResponse = await _networkAdapter.getRequest(Urls.getSingleEmployees(id));

    if (networkResponse.isSuccess) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(networkResponse.response);

        return EmployeeModel.fromJson(jsonData["data"]);
      } catch (e) {
        print(e);
        throw JsonSerializationException();
      }
    } else {
      throw ServerRequestFailedException(message: networkResponse.errorMessage);
    }
  }

  @override
  Future<EmployeeModel> createNewEmployee(EmployeeModel employee) async {
    final networkResponse = await _networkAdapter.postRequest(
      Urls.createEmployees,
      employee.toJson(),
    );

    if (networkResponse.isSuccess) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(networkResponse.response);

        return EmployeeModel.fromJsonV2(jsonData["data"]);
      } catch (e) {
        throw JsonSerializationException();
      }
    } else {
      throw ServerRequestFailedException(message: networkResponse.errorMessage);
    }
  }

  @override
  Future<int> deleteEmployee(int id) async {
    final networkResponse = await _networkAdapter.deleteRequest(
      Urls.deleteEmployees(id),
    );

    if (networkResponse.isSuccess) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(networkResponse.response);
        return int.parse(jsonData["data"]);
      } catch (e) {
        throw JsonSerializationException();
      }
    } else {
      throw ServerRequestFailedException(message: networkResponse.errorMessage);
    }
  }

  @override
  Future<EmployeeModel> updateEmployee(EmployeeModel employee) async {
    final networkResponse = await _networkAdapter.putRequest(
      Urls.updateEmployees(employee.id),
      employee.toJson(),
    );

    if (networkResponse.isSuccess) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(networkResponse.response);

        return EmployeeModel.fromJsonV2(jsonData["data"], employee.id);
      } catch (e) {
        throw JsonSerializationException();
      }
    } else {
      throw ServerRequestFailedException(message: networkResponse.errorMessage);
    }
  }
}

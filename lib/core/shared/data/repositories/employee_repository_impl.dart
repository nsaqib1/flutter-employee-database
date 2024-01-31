import 'package:fpdart/fpdart.dart';
import 'package:task_assignment/core/shared/data/models/employee_model.dart';

import '../../../error/exceptions.dart';
import '../../../error/failure.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/employees_repositories.dart';
import '../data_sources/employee_remote_data_source.dart';

class EmployeesRepositoryImpl implements EmployeesRepositories {
  final EmployeeRemoteDataSource _remoteDataSource;
  EmployeesRepositoryImpl({
    required EmployeeRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<EmployeeEntity>>> fetchAllEmployees() async {
    try {
      final employees = await _remoteDataSource.getAllEmployees();
      return right(employees);
    } on AppException catch (e) {
      return Left(_handleAppException(e));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> fetchSingleEmployee(int id) async {
    try {
      final employee = await _remoteDataSource.getSingleEmployee(id);
      return right(employee);
    } on AppException catch (e) {
      return Left(_handleAppException(e));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> createNewEmployee(EmployeeEntity employeeEntity) async {
    try {
      final employee = await _remoteDataSource.createNewEmployee(EmployeeModel.fromEntity(employeeEntity));
      return right(employee);
    } on AppException catch (e) {
      return Left(_handleAppException(e));
    }
  }

  @override
  Future<Either<Failure, int>> deleteEmployee(int id) async {
    try {
      final employeeId = await _remoteDataSource.deleteEmployee(id);
      return right(employeeId);
    } on AppException catch (e) {
      return Left(_handleAppException(e));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> updateEmployee(EmployeeEntity employee) async {
    try {
      final updatedEmployee = await _remoteDataSource.updateEmployee(EmployeeModel.fromEntity(employee));
      return right(updatedEmployee);
    } on AppException catch (e) {
      return Left(_handleAppException(e));
    }
  }

  Failure _handleAppException(AppException e) {
    switch (e.runtimeType) {
      case NetworkConnectionException:
        return Failure(msg: "Check your internet connection");
      case ServerRequestFailedException:
        e as ServerRequestFailedException;
        return Failure(msg: e.message);
      case JsonSerializationException:
        return Failure(msg: "Error converting data");
      default:
        return Failure(msg: "Something failed! Try again!");
    }
  }
}

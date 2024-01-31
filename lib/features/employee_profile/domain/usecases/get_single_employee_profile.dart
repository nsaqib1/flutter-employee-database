import 'package:fpdart/fpdart.dart';
import 'package:task_assignment/core/error/failure.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/core/shared/domain/repositories/employees_repositories.dart';

class GetSingleEmployeeProfile {
  final EmployeesRepositories _repositories;
  GetSingleEmployeeProfile({
    required EmployeesRepositories repositories,
  }) : _repositories = repositories;

  Future<Either<Failure, EmployeeEntity>> execute(int id) async {
    return await _repositories.fetchSingleEmployee(id);
  }
}

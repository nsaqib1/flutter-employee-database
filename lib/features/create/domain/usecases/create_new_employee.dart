import 'package:fpdart/fpdart.dart';
import 'package:task_assignment/core/error/failure.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/core/shared/domain/repositories/employees_repositories.dart';

class CreateNewEmployee {
  final EmployeesRepositories _repositories;
  CreateNewEmployee({
    required EmployeesRepositories repositories,
  }) : _repositories = repositories;

  Future<Either<Failure, EmployeeEntity>> execeute(EmployeeEntity employee) async {
    return await _repositories.createNewEmployee(employee);
  }
}

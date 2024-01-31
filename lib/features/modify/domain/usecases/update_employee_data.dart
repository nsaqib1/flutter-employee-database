import 'package:fpdart/fpdart.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/core/shared/domain/repositories/employees_repositories.dart';

import '../../../../core/error/failure.dart';

class UpdateEmployeeData {
  final EmployeesRepositories _repositories;
  UpdateEmployeeData({
    required EmployeesRepositories repositories,
  }) : _repositories = repositories;

  Future<Either<Failure, EmployeeEntity>> execute(EmployeeEntity employee) async {
    return await _repositories.updateEmployee(employee);
  }
}

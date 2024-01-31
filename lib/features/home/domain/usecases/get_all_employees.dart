import 'package:fpdart/fpdart.dart';
import 'package:task_assignment/core/error/failure.dart';

import '../../../../core/shared/domain/entities/employee_entity.dart';
import '../../../../core/shared/domain/repositories/employees_repositories.dart';

class GetAllEmployees {
  final EmployeesRepositories _repositories;
  GetAllEmployees({
    required EmployeesRepositories repositories,
  }) : _repositories = repositories;

  Future<Either<Failure, List<EmployeeEntity>>> execute() async {
    return await _repositories.fetchAllEmployees();
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:task_assignment/core/error/failure.dart';
import 'package:task_assignment/core/shared/domain/repositories/employees_repositories.dart';

class DeleteEmployeeData {
  final EmployeesRepositories _repositories;
  DeleteEmployeeData({
    required EmployeesRepositories repositories,
  }) : _repositories = repositories;

  Future<Either<Failure, int>> execute(int id) async {
    return await _repositories.deleteEmployee(id);
  }
}

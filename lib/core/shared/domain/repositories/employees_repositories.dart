import 'package:fpdart/fpdart.dart';

import '../../../error/failure.dart';
import '../entities/employee_entity.dart';

abstract class EmployeesRepositories {
  Future<Either<Failure, List<EmployeeEntity>>> fetchAllEmployees();
  Future<Either<Failure, EmployeeEntity>> fetchSingleEmployee(int id);
  Future<Either<Failure, EmployeeEntity>> createNewEmployee(EmployeeEntity employee);
  Future<Either<Failure, EmployeeEntity>> updateEmployee(EmployeeEntity employee);
  Future<Either<Failure, int>> deleteEmployee(int id);
}

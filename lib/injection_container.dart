import 'package:get_it/get_it.dart';
import 'package:task_assignment/core/shared/domain/repositories/employees_repositories.dart';
import 'package:task_assignment/features/create/bloc/create_bloc.dart';
import 'package:task_assignment/features/create/domain/usecases/create_new_employee.dart';
import 'package:task_assignment/features/employee_profile/domain/usecases/get_single_employee_profile.dart';
import 'package:task_assignment/features/employee_profile/presentation/bloc/employee_profile_bloc.dart';
import 'package:task_assignment/features/modify/domain/usecases/delete_employee_data.dart';
import 'package:task_assignment/features/modify/domain/usecases/update_employee_data.dart';
import 'package:task_assignment/features/modify/presentation/blocs/delete_bloc/delete_bloc.dart';
import 'package:task_assignment/features/modify/presentation/blocs/update_bloc/update_bloc.dart';

import 'core/network/network_adapter.dart';
import 'core/shared/data/data_sources/employee_remote_data_source.dart';
import 'core/shared/data/repositories/employee_repository_impl.dart';
import 'features/home/domain/usecases/get_all_employees.dart';
import 'features/home/presentation/bloc/employee_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - Home

  // blocs
  sl.registerFactory(() => EmployeeListBloc(getAllEmployees: sl()));

  // usecases
  sl.registerLazySingleton(() => GetAllEmployees(repositories: sl()));

  // Repositories
  sl.registerLazySingleton<EmployeesRepositories>(() => EmployeesRepositoryImpl(remoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<EmployeeRemoteDataSource>(() => EmployeeRemoteDataSourceImpl(networkAdapter: sl()));

  //! Feature = Employee Profile

  // Blocs
  sl.registerFactory(() => EmployeeProfileBloc(getSingleEmployeeProfile: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetSingleEmployeeProfile(repositories: sl()));

  //! Feature - Create Employee

  // Blocs
  sl.registerFactory(() => CreateBloc(createNewEmployee: sl()));

  // Usecase
  sl.registerLazySingleton(() => CreateNewEmployee(repositories: sl()));

  //! Modify Employee Profile

  // Blocs
  sl.registerFactory(() => DeleteBloc(deleteEmployeeData: sl()));
  sl.registerFactory(() => UpdateBloc(updateEmployeeData: sl()));

  // Usecase
  sl.registerLazySingleton(() => DeleteEmployeeData(repositories: sl()));
  sl.registerLazySingleton(() => UpdateEmployeeData(repositories: sl()));

  //! External

  // Network Adapter
  sl.registerLazySingleton<NetworkAdapter>(() => NetworkAdapterImpl());
}

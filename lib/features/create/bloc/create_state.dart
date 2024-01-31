part of 'create_bloc.dart';

@immutable
sealed class CreateState {}

final class CreateInitialState extends CreateState {}

final class CreateEmployeeInProgressState extends CreateState {}

final class CreateEmployeeSuccessState extends CreateState {
  final EmployeeEntity employeeEntity;

  CreateEmployeeSuccessState({required this.employeeEntity});
}

final class CreateEmployeeFailureState extends CreateState {
  final String errorMessage;
  CreateEmployeeFailureState({required this.errorMessage});
}

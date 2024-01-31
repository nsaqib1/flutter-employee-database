part of 'employee_profile_bloc.dart';

@immutable
sealed class EmployeeProfileState {}

final class EmployeeProfileInitialState extends EmployeeProfileState {}

final class EmployeeProfileLoadInProgressState extends EmployeeProfileState {}

final class EmployeeProfileLoadSuccessState extends EmployeeProfileState {
  final EmployeeEntity employee;

  EmployeeProfileLoadSuccessState({required this.employee});
}

final class EmployeeProfileLoadFailureState extends EmployeeProfileState {
  final String errorMessage;

  EmployeeProfileLoadFailureState({required this.errorMessage});
}

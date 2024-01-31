part of 'employee_list_bloc.dart';

@immutable
sealed class EmployeeListState {}

final class EmployeeListInitialState extends EmployeeListState {}

final class EmployeeListLoadInProgressState extends EmployeeListState {}

final class EmployeeListLoadSuccessState extends EmployeeListState {
  final List<EmployeeEntity> employeeList;
  EmployeeListLoadSuccessState({required this.employeeList});
}

final class EmployeeListLoadFailureState extends EmployeeListState {
  final String errorMessage;
  EmployeeListLoadFailureState({required this.errorMessage});
}

@immutable
sealed class EmployeeListActionState extends EmployeeListState {}

final class EmployeeListNavigateToCreateActionState extends EmployeeListActionState {}

final class EmployeeListNavigateToProfileActionState extends EmployeeListActionState {
  final int id;
  EmployeeListNavigateToProfileActionState({required this.id});
}

final class EmployeeListNavigateToModifyActionState extends EmployeeListActionState {
  final EmployeeEntity employee;
  EmployeeListNavigateToModifyActionState({required this.employee});
}

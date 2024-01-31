part of 'employee_list_bloc.dart';

@immutable
sealed class EmployeeListEvent {}

class EmployeeListLoadEvent extends EmployeeListEvent {}

class EmployeeListNavigateToCreateEvent extends EmployeeListEvent {}

class EmployeeListNavigateToProfileEvent extends EmployeeListEvent {
  final int id;
  EmployeeListNavigateToProfileEvent({required this.id});
}

class EmployeeListNavigateToModifyEvent extends EmployeeListEvent {
  final EmployeeEntity employee;
  EmployeeListNavigateToModifyEvent({required this.employee});
}

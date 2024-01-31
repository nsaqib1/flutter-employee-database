part of 'employee_profile_bloc.dart';

@immutable
sealed class EmployeeProfileEvent {}

class EmployeeProfileLoadEvent extends EmployeeProfileEvent {
  final int id;

  EmployeeProfileLoadEvent({required this.id});
}

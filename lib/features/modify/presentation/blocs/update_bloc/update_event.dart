part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class UpdateEmployeeDataEvent extends UpdateEvent {
  final int id;
  final String name;
  final String salary;
  final String age;

  UpdateEmployeeDataEvent({
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
  });
}

class UpdateEmployeeResetEvent extends UpdateEvent {}

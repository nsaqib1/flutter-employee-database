part of 'create_bloc.dart';

@immutable
sealed class CreateEvent {}

class CreateEmployeeEvent extends CreateEvent {
  final String name;
  final int age;
  final int salary;

  CreateEmployeeEvent({
    required this.name,
    required this.age,
    required this.salary,
  });
}

class CreateEmployeeResetEvent extends CreateEvent {}

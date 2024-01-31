part of 'delete_bloc.dart';

@immutable
sealed class DeleteEvent {}

class DeleteEmployeeEvent extends DeleteEvent {
  final int id;
  DeleteEmployeeEvent({required this.id});
}

class DeleteEmployeeResetEvent extends DeleteEvent {}

part of 'delete_bloc.dart';

@immutable
sealed class DeleteState {}

final class DeleteInitialState extends DeleteState {}

final class DeleteEmployeeInProgressState extends DeleteState {}

final class DeleteEmployeeSuccessState extends DeleteState {
  final int id;
  DeleteEmployeeSuccessState({required this.id});
}

final class DeleteEmployeeFailureState extends DeleteState {
  final String errorMessage;
  DeleteEmployeeFailureState({required this.errorMessage});
}

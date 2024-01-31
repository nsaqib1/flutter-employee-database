part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitialState extends UpdateState {}

final class UpdateEmployeeInProgressState extends UpdateState {}

final class UpdateEmployeeSuccessState extends UpdateState {
  final EmployeeEntity employee;
  UpdateEmployeeSuccessState({required this.employee});
}

final class UpdateEmployeeFailureState extends UpdateState {
  final String errorMessage;
  UpdateEmployeeFailureState({required this.errorMessage});
}

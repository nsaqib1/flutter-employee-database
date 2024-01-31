import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_assignment/features/modify/domain/usecases/delete_employee_data.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  final DeleteEmployeeData _deleteEmployeeData;
  DeleteBloc({
    required DeleteEmployeeData deleteEmployeeData,
  })  : _deleteEmployeeData = deleteEmployeeData,
        super(DeleteInitialState()) {
    on<DeleteEmployeeEvent>(deleteEmployeeEvent);
    on<DeleteEmployeeResetEvent>(deleteEmployeeResetEvent);
  }

  FutureOr<void> deleteEmployeeEvent(
    DeleteEmployeeEvent event,
    Emitter<DeleteState> emit,
  ) async {
    emit(DeleteEmployeeInProgressState());
    final result = await _deleteEmployeeData.execute(event.id);
    result.fold(
      (l) => emit(DeleteEmployeeFailureState(errorMessage: l.msg)),
      (r) => emit(DeleteEmployeeSuccessState(id: r)),
    );
  }

  FutureOr<void> deleteEmployeeResetEvent(
    DeleteEmployeeResetEvent event,
    Emitter<DeleteState> emit,
  ) {
    emit(DeleteInitialState());
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/features/modify/domain/usecases/update_employee_data.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpdateEmployeeData _updateEmployeeData;
  UpdateBloc({
    required UpdateEmployeeData updateEmployeeData,
  })  : _updateEmployeeData = updateEmployeeData,
        super(UpdateInitialState()) {
    on<UpdateEmployeeDataEvent>(updateEmployeeDataEvent);
    on<UpdateEmployeeResetEvent>(updateEmployeeResetEvent);
  }

  FutureOr<void> updateEmployeeDataEvent(
    UpdateEmployeeDataEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(UpdateEmployeeInProgressState());
    final result = await _updateEmployeeData.execute(
      EmployeeEntity(
        id: event.id,
        employeeName: event.name,
        employeeSalary: int.parse(event.salary),
        employeeAge: int.parse(event.age),
        profileImage: "",
      ),
    );

    result.fold(
      (l) => emit(UpdateEmployeeFailureState(errorMessage: l.msg)),
      (r) => emit(UpdateEmployeeSuccessState(employee: r)),
    );
  }

  FutureOr<void> updateEmployeeResetEvent(
    UpdateEmployeeResetEvent event,
    Emitter<UpdateState> emit,
  ) {
    emit(UpdateInitialState());
  }
}

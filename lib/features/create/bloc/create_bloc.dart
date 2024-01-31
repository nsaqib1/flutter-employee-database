import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/features/create/domain/usecases/create_new_employee.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final CreateNewEmployee _createNewEmployee;
  CreateBloc({
    required CreateNewEmployee createNewEmployee,
  })  : _createNewEmployee = createNewEmployee,
        super(CreateInitialState()) {
    on<CreateEmployeeEvent>(createEmployeeEvent);
    on<CreateEmployeeResetEvent>(createEmployeeResetEvent);
  }

  FutureOr<void> createEmployeeEvent(
    CreateEmployeeEvent event,
    Emitter<CreateState> emit,
  ) async {
    emit(CreateEmployeeInProgressState());
    final result = await _createNewEmployee.execeute(
      EmployeeEntity(
        id: 0,
        employeeName: event.name,
        employeeSalary: event.salary,
        employeeAge: event.age,
        profileImage: "",
      ),
    );

    result.fold(
      (l) => emit(CreateEmployeeFailureState(errorMessage: l.msg)),
      (r) => emit(CreateEmployeeSuccessState(employeeEntity: r)),
    );
  }

  FutureOr<void> createEmployeeResetEvent(
    CreateEmployeeResetEvent event,
    Emitter<CreateState> emit,
  ) {
    emit(CreateInitialState());
  }
}

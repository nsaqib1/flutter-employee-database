import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/shared/domain/entities/employee_entity.dart';
import '../../domain/usecases/get_all_employees.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final GetAllEmployees _getAllEmployees;
  EmployeeListBloc({
    required GetAllEmployees getAllEmployees,
  })  : _getAllEmployees = getAllEmployees,
        super(EmployeeListInitialState()) {
    on<EmployeeListLoadEvent>(employeeListLoadEvent);
    on<EmployeeListNavigateToCreateEvent>(employeeListNavigateToCreateEvent);
    on<EmployeeListNavigateToModifyEvent>(employeeListNavigateToModifyEvent);
    on<EmployeeListNavigateToProfileEvent>(employeeListNavigateToProfileEvent);
  }

  FutureOr<void> employeeListLoadEvent(
    EmployeeListLoadEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    emit(EmployeeListLoadInProgressState());
    final result = await _getAllEmployees.execute();
    result.fold(
      (l) => emit(EmployeeListLoadFailureState(errorMessage: l.msg)),
      (r) => emit(
        EmployeeListLoadSuccessState(employeeList: r),
      ),
    );
  }

  FutureOr<void> employeeListNavigateToCreateEvent(
    EmployeeListNavigateToCreateEvent event,
    Emitter<EmployeeListState> emit,
  ) {
    emit(EmployeeListNavigateToCreateActionState());
  }

  FutureOr<void> employeeListNavigateToModifyEvent(
    EmployeeListNavigateToModifyEvent event,
    Emitter<EmployeeListState> emit,
  ) {
    emit(EmployeeListNavigateToModifyActionState(employee: event.employee));
  }

  FutureOr<void> employeeListNavigateToProfileEvent(
    EmployeeListNavigateToProfileEvent event,
    Emitter<EmployeeListState> emit,
  ) {
    emit(EmployeeListNavigateToProfileActionState(id: event.id));
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/features/employee_profile/domain/usecases/get_single_employee_profile.dart';

part 'employee_profile_event.dart';
part 'employee_profile_state.dart';

class EmployeeProfileBloc extends Bloc<EmployeeProfileEvent, EmployeeProfileState> {
  final GetSingleEmployeeProfile _getSingleEmployeeProfile;
  EmployeeProfileBloc({
    required GetSingleEmployeeProfile getSingleEmployeeProfile,
  })  : _getSingleEmployeeProfile = getSingleEmployeeProfile,
        super(EmployeeProfileInitialState()) {
    on<EmployeeProfileLoadEvent>(employeProfileLoadEvent);
  }

  FutureOr<void> employeProfileLoadEvent(
    EmployeeProfileLoadEvent event,
    Emitter<EmployeeProfileState> emit,
  ) async {
    emit(EmployeeProfileLoadInProgressState());
    final result = await _getSingleEmployeeProfile.execute(event.id);
    result.fold(
      (l) => emit(EmployeeProfileLoadFailureState(errorMessage: l.msg)),
      (r) => emit(EmployeeProfileLoadSuccessState(employee: r)),
    );
  }
}

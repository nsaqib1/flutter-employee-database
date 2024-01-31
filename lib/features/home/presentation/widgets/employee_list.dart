import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/features/modify/presentation/screens/modify_employee_screen.dart';

import '../../../../core/shared/domain/entities/employee_entity.dart';
import '../../../employee_profile/presentation/screens/employee_profile_screen.dart';
import '../bloc/employee_list_bloc.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeListBloc, EmployeeListState>(
      listenWhen: (previous, current) => current is EmployeeListActionState,
      listener: (context, state) {
        if (state.runtimeType == EmployeeListNavigateToProfileActionState) {
          state as EmployeeListNavigateToProfileActionState;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeProfileScreen(employeeId: state.id),
            ),
          );
        }
        if (state.runtimeType == EmployeeListNavigateToModifyActionState) {
          state as EmployeeListNavigateToModifyActionState;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ModifyEmployeeScreen(employee: state.employee),
            ),
          );
        }
      },
      buildWhen: (previous, current) => current is! EmployeeListActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case EmployeeListLoadInProgressState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case EmployeeListLoadSuccessState:
            state as EmployeeListLoadSuccessState;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => EmployeeListCard(employee: state.employeeList[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: state.employeeList.length,
            );
          case EmployeeListLoadFailureState:
            state as EmployeeListLoadFailureState;
            return Center(
              child: Text(state.errorMessage),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class EmployeeListCard extends StatelessWidget {
  const EmployeeListCard({
    super.key,
    required this.employee,
  });

  final EmployeeEntity employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        onLongPress: () {
          context.read<EmployeeListBloc>().add(EmployeeListNavigateToModifyEvent(employee: employee));
        },
        onTap: () {
          context.read<EmployeeListBloc>().add(EmployeeListNavigateToProfileEvent(id: employee.id));
        },
        leading: CircleAvatar(
          backgroundImage: Image.asset("assets/images/avatar.jpeg").image,
        ),
        title: Text(employee.employeeName),
        subtitle: Text("Age ${employee.employeeAge}"),
        trailing: Text(
          "\$${employee.employeeSalary}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

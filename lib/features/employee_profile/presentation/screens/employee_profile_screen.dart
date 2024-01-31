import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/presentation/widgets/employee_profile_card.dart';
import '../bloc/employee_profile_bloc.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key, required this.employeeId});

  final int employeeId;

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeProfileBloc>().add(EmployeeProfileLoadEvent(id: widget.employeeId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: _employeeProfileCard,
      ),
    );
  }

  BlocBuilder get _employeeProfileCard => BlocBuilder<EmployeeProfileBloc, EmployeeProfileState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case EmployeeProfileLoadInProgressState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case EmployeeProfileLoadFailureState:
              state as EmployeeProfileLoadFailureState;
              return Center(
                child: Text(state.errorMessage),
              );
            case EmployeeProfileLoadSuccessState:
              state as EmployeeProfileLoadSuccessState;
              return EmployeeProfileCard(
                employee: state.employee,
              );
            default:
              return const SizedBox.shrink();
          }
        },
      );
}

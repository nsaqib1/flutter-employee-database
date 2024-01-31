import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/features/create/presentation/screens/create_profile_screen.dart';

import '../../../../core/shared/domain/entities/employee_entity.dart';
import '../bloc/employee_list_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeListBloc, EmployeeListState>(
      listenWhen: (previous, current) => current is EmployeeListActionState,
      listener: (context, state) {
        if (state.runtimeType == EmployeeListNavigateToCreateActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateProfileScreen(),
            ),
          );
        }
      },
      buildWhen: (previous, current) => current is! EmployeeListActionState,
      builder: (context, state) {
        List<EmployeeEntity>? list;
        int totalEmployee = 0;
        double averageAge = 0;
        double averageSalary = 0;
        if (state is EmployeeListLoadSuccessState) {
          list = state.employeeList;

          totalEmployee = list.length;

          final double totalAge = list.fold(0, (previousValue, element) => previousValue + element.employeeAge);
          averageAge = totalAge / totalEmployee;

          final double totalSalary = list.fold(0, (previousValue, element) => previousValue + element.employeeSalary);
          averageSalary = totalSalary / totalEmployee;
        }
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.3,
          shrinkWrap: true,
          children: [
            DashboardMetricCard(
              color: Colors.indigo,
              data: "$totalEmployee",
              label: "Total Employee",
            ),
            DashboardMetricCard(
              color: Colors.pink,
              data: averageAge.toStringAsFixed(0),
              label: "Average Age",
            ),
            DashboardMetricCard(
              color: Colors.green,
              data: "\$${averageSalary.toStringAsFixed(0)}",
              label: "Average Salary",
            ),
            addEmployeeButton,
          ],
        );
      },
    );
  }

  TextButton get addEmployeeButton => TextButton(
        onPressed: () {
          context.read<EmployeeListBloc>().add(EmployeeListNavigateToCreateEvent());
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 48,
            ),
            Text("Add New Employee"),
          ],
        ),
      );
}

class DashboardMetricCard extends StatelessWidget {
  const DashboardMetricCard({
    super.key,
    required this.color,
    required this.data,
    required this.label,
  });

  final Color color;
  final String data;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                data,
                style: TextStyle(
                  color: color,
                  fontSize: 48,
                ),
              ),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

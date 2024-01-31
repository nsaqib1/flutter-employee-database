import 'package:flutter/material.dart';

import '../../domain/entities/employee_entity.dart';

class EmployeeProfileCard extends StatelessWidget {
  const EmployeeProfileCard({
    super.key,
    required this.employee,
  });

  final EmployeeEntity employee;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: Image.asset("assets/images/avatar.jpeg").image,
        ),
        const SizedBox(height: 10),
        Text(
          employee.employeeName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "Age: ${employee.employeeAge}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Text(
          "Salary: \$${employee.employeeSalary}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Text(
          "Employee ID: ${employee.id}",
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

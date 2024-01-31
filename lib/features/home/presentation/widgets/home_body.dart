import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/employee_list_bloc.dart';
import 'dashboard.dart';
import 'employee_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: const Column(
        children: [
          SizedBox(height: 20),
          Dashboard(),
          SizedBox(height: 20),
          EmployeeListBanner(),
          SizedBox(height: 10),
          Flexible(
            child: EmployeeList(),
          ),
        ],
      ),
    );
  }
}

class EmployeeListBanner extends StatelessWidget {
  const EmployeeListBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: const Border(
          left: BorderSide(
            color: Colors.blue,
            width: 4,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Employees List"),
          IconButton(
            onPressed: () {
              context.read<EmployeeListBloc>().add(EmployeeListLoadEvent());
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
    );
  }
}

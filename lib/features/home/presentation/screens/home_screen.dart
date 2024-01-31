import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/features/home/presentation/bloc/employee_list_bloc.dart';

import '../widgets/home_body.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeListBloc>().add(EmployeeListLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const SafeArea(
          child: Column(
            children: [
              AppHeader(),
              Expanded(
                child: HomeBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

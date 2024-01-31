import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/core/theme/default_theme.dart';
import 'package:task_assignment/features/create/bloc/create_bloc.dart';
import 'package:task_assignment/features/employee_profile/presentation/bloc/employee_profile_bloc.dart';
import 'package:task_assignment/features/home/presentation/bloc/employee_list_bloc.dart';
import 'package:task_assignment/features/home/presentation/screens/home_screen.dart';
import 'package:task_assignment/features/modify/presentation/blocs/delete_bloc/delete_bloc.dart';
import 'package:task_assignment/features/modify/presentation/blocs/update_bloc/update_bloc.dart';

import 'injection_container.dart';

class EmployeeDatabaseApp extends StatelessWidget {
  const EmployeeDatabaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<EmployeeListBloc>()),
        BlocProvider(create: (context) => sl<EmployeeProfileBloc>()),
        BlocProvider(create: (context) => sl<CreateBloc>()),
        BlocProvider(create: (context) => sl<DeleteBloc>()),
        BlocProvider(create: (context) => sl<UpdateBloc>()),
      ],
      child: MaterialApp(
        title: "Employee Database",
        theme: DefaultTheme.data,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}

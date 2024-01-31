import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/core/shared/domain/entities/employee_entity.dart';
import 'package:task_assignment/features/modify/presentation/blocs/update_bloc/update_bloc.dart';

import '../blocs/delete_bloc/delete_bloc.dart';

class ModifyEmployeeScreen extends StatefulWidget {
  const ModifyEmployeeScreen({super.key, required this.employee});

  final EmployeeEntity employee;

  @override
  State<ModifyEmployeeScreen> createState() => _ModifyEmployeeScreenState();
}

class _ModifyEmployeeScreenState extends State<ModifyEmployeeScreen> {
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _ageController = TextEditingController();

  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.employee.employeeName;
    _salaryController.text = widget.employee.employeeSalary.toString();
    _ageController.text = widget.employee.employeeAge.toString();

    context.read<DeleteBloc>().add(DeleteEmployeeResetEvent());
    context.read<UpdateBloc>().add(UpdateEmployeeResetEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _delete() {
    context.read<DeleteBloc>().add(DeleteEmployeeEvent(id: widget.employee.id));
  }

  void _update() {
    if (context.read<DeleteBloc>().state.runtimeType == DeleteEmployeeSuccessState) return;
    if (_fromKey.currentState!.validate() == false) return;

    context.read<UpdateBloc>().add(UpdateEmployeeDataEvent(
          id: widget.employee.id,
          name: _nameController.text,
          salary: _salaryController.text,
          age: _ageController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update or Delete"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _nameTextField,
                const SizedBox(height: 20),
                _ageTextField,
                const SizedBox(height: 20),
                _salaryTextField,
                const SizedBox(height: 40),
                _updateButton,
                const SizedBox(height: 20),
                _deleteButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField get _nameTextField => TextFormField(
        controller: _nameController,
        validator: (value) => value!.isEmpty ? "Name is required!" : null,
        decoration: const InputDecoration(
          labelText: "Name",
          hintText: "Name",
        ),
        keyboardType: TextInputType.name,
      );

  TextFormField get _ageTextField => TextFormField(
        controller: _ageController,
        validator: (value) => value!.isEmpty ? "Age is required!" : null,
        decoration: const InputDecoration(
          labelText: "Age",
          hintText: "Age",
        ),
        keyboardType: TextInputType.number,
      );

  TextFormField get _salaryTextField => TextFormField(
        controller: _salaryController,
        keyboardType: TextInputType.number,
        validator: (value) => value!.isEmpty ? "Salary is required!" : null,
        decoration: const InputDecoration(
          labelText: "Salaray",
          hintText: "Salaray",
        ),
      );

  BlocBuilder get _updateButton => BlocBuilder<UpdateBloc, UpdateState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case UpdateEmployeeInProgressState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case UpdateEmployeeSuccessState:
              return const ElevatedButton(
                onPressed: null,
                child: Text("Updated Successfully"),
              );
            case UpdateEmployeeFailureState:
              state as UpdateEmployeeFailureState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _update,
                    child: const Text("Updated"),
                  ),
                  const SizedBox(height: 10),
                  Text("Update Failed: ${state.errorMessage}"),
                ],
              );
            default:
              return ElevatedButton(
                onPressed: _update,
                child: const Text("Update"),
              );
          }
        },
      );

  BlocBuilder get _deleteButton => BlocBuilder<DeleteBloc, DeleteState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case DeleteEmployeeInProgressState:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red.shade600,
                ),
              );
            case DeleteEmployeeSuccessState:
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                ),
                onPressed: null,
                child: const Text("Deleted Successfully"),
              );
            case DeleteEmployeeFailureState:
              state as DeleteEmployeeFailureState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                    ),
                    onPressed: _delete,
                    child: const Text("Delete"),
                  ),
                  const SizedBox(height: 10),
                  Text(state.errorMessage),
                ],
              );
            default:
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                ),
                onPressed: _delete,
                child: const Text("Delete"),
              );
          }
        },
      );
}

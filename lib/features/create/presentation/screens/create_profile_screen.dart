import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/core/shared/presentation/widgets/employee_profile_card.dart';

import '../../bloc/create_bloc.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _ageController = TextEditingController();

  final _fromKey = GlobalKey<FormState>();

  Future<void> _create() async {
    if (_fromKey.currentState!.validate()) {
      context.read<CreateBloc>().add(
            CreateEmployeeEvent(
              name: _nameController.text,
              age: int.parse(_ageController.text),
              salary: int.parse(_salaryController.text),
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CreateBloc>().add(CreateEmployeeResetEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _salaryController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a New Profile"),
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
                _createButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder get _createButton => BlocBuilder<CreateBloc, CreateState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CreateEmployeeSuccessState:
              state as CreateEmployeeSuccessState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _create,
                    child: const Text("Create"),
                  ),
                  const SizedBox(height: 20),
                  EmployeeProfileCard(employee: state.employeeEntity),
                ],
              );
            case CreateEmployeeFailureState:
              state as CreateEmployeeFailureState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _create,
                    child: const Text("Create"),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(state.errorMessage),
                  ),
                ],
              );
            default:
              return Visibility(
                visible: state.runtimeType != CreateEmployeeInProgressState,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                  onPressed: _create,
                  child: const Text("Create"),
                ),
              );
          }
        },
      );

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
}

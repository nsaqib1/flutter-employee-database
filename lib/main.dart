import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_assignment/app.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(const EmployeeDatabaseApp());
}

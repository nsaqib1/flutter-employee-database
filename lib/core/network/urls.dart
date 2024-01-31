abstract class Urls {
  static const String _base = "https://dummy.restapiexample.com/api/v1";

  static const getAllEmployees = "$_base/employees";
  static String getSingleEmployees(int id) => "$_base/employee/$id";
  static const String createEmployees = "$_base/create";
  static String deleteEmployees(int id) => "$_base/delete/$id";
  static String updateEmployees(int id) => "$_base/update/$id";
}

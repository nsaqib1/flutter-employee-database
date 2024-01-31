import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    required super.id,
    required super.employeeName,
    required super.employeeSalary,
    required super.employeeAge,
    required super.profileImage,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json["id"],
      employeeName: json["employee_name"],
      employeeSalary: json["employee_salary"],
      employeeAge: json["employee_age"],
      profileImage: json["profile_image"],
    );
  }

  factory EmployeeModel.fromJsonV2(Map<String, dynamic> json, [int? id]) {
    return EmployeeModel(
      id: json["id"] ?? id ?? -1,
      employeeName: json["name"],
      employeeSalary: int.tryParse(json["salary"]) ?? -1,
      employeeAge: int.tryParse(json["age"]) ?? -1,
      profileImage: "",
    );
  }

  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
      id: entity.id,
      employeeName: entity.employeeName,
      employeeSalary: entity.employeeSalary,
      employeeAge: entity.employeeAge,
      profileImage: entity.profileImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": employeeName,
      "salary": employeeSalary.toString(),
      "age": employeeAge.toString(),
    };
  }
}

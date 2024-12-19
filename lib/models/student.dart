import '../models/Department.dart';

enum Gender { male, female }

class Student {
  String firstName;
  String lastName;
  Department department;
  int grade;
  Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

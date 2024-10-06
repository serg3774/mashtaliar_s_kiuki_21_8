import 'package:flutter/material.dart';

enum Department { finance, law, it, medical }

const departmentIcons = {
  Department.finance: Icons.attach_money,
  Department.law: Icons.gavel,
  Department.it: Icons.computer,
  Department.medical: Icons.local_hospital,
};

enum Gender { male, female }

const genderColor = {
  Gender.male: Colors.blue,
  Gender.female: Colors.pink,
};

class StudentsModel {
  StudentsModel({
    required this.firstName,
    required this.lastName,
    required this.grade,
    required this.department,
    required this.gender,
  });

  final String firstName;
  final String lastName;
  final int grade;
  final Department department;
  final Gender gender;
}

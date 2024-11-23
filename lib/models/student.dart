import 'package:flutter/material.dart';

enum Department { finance, law, it, medical }

enum Gender { male, female }

final Map<Department, String> icons = {
  Department.finance: "finance.png",
  Department.law: "law.png",
  Department.it: "it.png",
  Department.medical: "medicine.png",
};

final Map<Gender, Color> GenderColor = {
  Gender.male: Colors.blue,
  Gender.female: Colors.pink,
};

class Student {
  String firstName;
  String lastName;
  Gender gender;
  int grade;
  Department department;

  Student(
      this.firstName, this.lastName, this.gender, this.grade, this.department);
}

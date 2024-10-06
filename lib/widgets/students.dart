import 'package:flutter/material.dart';
import 'package:mashtaliar_s_kiuki_21_8/models/student.dart';
import 'package:mashtaliar_s_kiuki_21_8/models/student_list.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StudentsState();
  }
}

class _StudentsState extends State<Students> {
  final List<StudentsModel> _registeredStudents = [
    StudentsModel(
        firstName: "Serhii",
        lastName: "Mashtaliar",
        grade: 9,
        department: Department.it,
        gender: Gender.male),
    StudentsModel(
        firstName: "Valera",
        lastName: "Dmitrenko",
        grade: 8,
        department: Department.medical,
        gender: Gender.male),
    StudentsModel(
        firstName: "Karina",
        lastName: "Ivanova",
        grade: 9,
        department: Department.law,
        gender: Gender.female),
    StudentsModel(
        firstName: "Andrii",
        lastName: "Kisliy",
        grade: 10,
        department: Department.finance,
        gender: Gender.male),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Column(
        children: [
          Expanded(child: StudentList(students: _registeredStudents)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mashtaliar_s_kiuki_21_8/models/student.dart';
import 'package:mashtaliar_s_kiuki_21_8/widgets/students_item.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key, required this.students});

  final List<StudentsModel> students;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) =>
          StudentsItem(studentsModel: students[index]),
    );
  }
}

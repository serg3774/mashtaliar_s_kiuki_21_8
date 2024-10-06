import 'package:flutter/material.dart';
import 'package:mashtaliar_s_kiuki_21_8/models/student.dart';

class StudentsItem extends StatelessWidget {
  const StudentsItem({super.key, required this.studentsModel});

  final StudentsModel studentsModel;

  @override
  Widget build(BuildContext context) {
    Color background = genderColor[studentsModel.gender] ?? Colors.white;

    return Card(
      color: background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  studentsModel.firstName,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(studentsModel.lastName),
                const Spacer(),
                Row(
                  children: [
                    Icon(departmentIcons[studentsModel.department]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(studentsModel.grade.toString()),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

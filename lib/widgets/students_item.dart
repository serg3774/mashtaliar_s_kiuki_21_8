import 'package:flutter/material.dart';
import 'package:mashtaliar_s_kiuki_21_8/models/student.dart';

class StudentsItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int grade;
  final Color? colorName;
  final String? iconPath;

  const StudentsItem({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.grade,
    required this.colorName,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: colorName,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$firstName $lastName',
                style: TextStyle(color: Colors.purple),
              ),
              Row(
                children: [
                  Image.asset(iconPath ?? '', width: 70, height: 70),
                  Text(
                    "$grade",
                    style: TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ],
          ),
          tileColor: Colors.transparent,
        ),
      ),
    );
  }
}

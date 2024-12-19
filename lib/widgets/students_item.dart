import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        color: colorName,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(iconPath ?? '', width: 50, height: 50),
        title: Text('$firstName $lastName'),
        subtitle: Text('Grade: $grade'),
      ),
    );
  }
}

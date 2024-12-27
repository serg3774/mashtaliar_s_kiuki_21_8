import 'package:flutter/material.dart';

class DepartmentItem extends StatelessWidget {
  final String name;
  final int studentCount;
  final String iconPath;
  final Color color;

  const DepartmentItem({
    super.key,
    required this.name,
    required this.studentCount,
    required this.iconPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            'Студентов: $studentCount',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

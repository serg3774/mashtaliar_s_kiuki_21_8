import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/departments_provider.dart';
import '../providers/students_provider.dart';

class DepartmentsScreen extends ConsumerWidget {
  const DepartmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentsProvider);
    final students = ref.watch(studentsProvider);

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final department = departments[index];
        final count = students.where((s) => s.department.id == department.id).length;

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: department.color.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(department.icon, width: 50, height: 50),
                const SizedBox(height: 10),
                Text(
                  department.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$count students',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

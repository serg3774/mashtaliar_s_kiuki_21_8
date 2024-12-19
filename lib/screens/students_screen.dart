import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/departments_provider.dart';
import '../providers/students_provider.dart';
import '../widgets/students_item.dart';
import '../widgets/createStudent.dart';
import '../models/student.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  void _editStudent(BuildContext context, WidgetRef ref, int index, Student student) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewStudent(
        student: student,
        onSave: (updatedStudent) {
          ref.read(studentsProvider.notifier).editStudent(updatedStudent, index);
        },
      ),
    );
  }

  void _deleteStudent(BuildContext context, WidgetRef ref, int index) {
    final students = ref.read(studentsProvider);
    final removedStudent = students[index];
    ref.read(studentsProvider.notifier).removeStudent(index);
    final container = ProviderScope.containerOf(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedStudent.firstName} ${removedStudent.lastName} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            container.read(studentsProvider.notifier).undo();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final departments = ref.watch(departmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final department = departments.firstWhere((d) => d.id == student.department.id);

          return Dismissible(
            key: ValueKey(student),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16.0),
              child: const Icon(Icons.delete, color: Colors.white, size: 32),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (_) => _deleteStudent(context, ref, index),
            child: GestureDetector(
              onTap: () => _editStudent(context, ref, index, student),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: StudentsItem(
                  firstName: student.firstName,
                  lastName: student.lastName,
                  grade: student.grade,
                  colorName: department.color.withOpacity(0.2),
                  iconPath: department.icon,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) => NewStudent(
            onSave: (student) => ref.read(studentsProvider.notifier).addStudent(student),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
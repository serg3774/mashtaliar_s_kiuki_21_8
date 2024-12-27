import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/departments_provider.dart';
import '../providers/students_provider.dart';
import '../widgets/students_item.dart';
import '../widgets/createStudent.dart';
import '../models/student.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  void _editStudent(BuildContext context, WidgetRef ref, int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewStudent(elemIndex: index),
    );
  }

  void _deleteStudent(BuildContext context, WidgetRef ref, int index) {
    final screenState = ref.read(studentsProvider);
    final removedStudent = screenState.students[index];
    ref.read(studentsProvider.notifier).delete(index);
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
    ).closed.then((value) {
      if (value != SnackBarClosedReason.action) {
        ref.read(studentsProvider.notifier).remove();
      }
    });

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(studentsProvider);
    final departments = ref.watch(departmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: screenState.students.length,
        itemBuilder: (context, index) {
          final student = screenState.students[index];
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
              onTap: () => _editStudent(context, ref, index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: StudentsItem(
                  firstName: student.firstName,
                  lastName: student.lastName,
                  grade: student.grade,
                  isFemale: student.gender == Gender.female,
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
          builder: (_) => const NewStudent(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
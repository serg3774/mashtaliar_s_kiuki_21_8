import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../models/Department.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  Student? _removedStudent;
  int? _removedIndex;

  void addStudent(Student student) {
    state = [...state, student];
  }

  void removeStudent(int index) {
    _removedStudent = state[index];
    _removedIndex = index;
    state = [...state]..removeAt(index);
  }

  void undo() {
    if (_removedStudent != null && _removedIndex != null) {
      state = [...state]..insert(_removedIndex!, _removedStudent!);
      _removedStudent = null;
      _removedIndex = null;
    }
  }

  void editStudent(Student updatedStudent, int index) {
    final updatedList = [...state];
    updatedList[index] = updatedStudent;
    state = updatedList;
  }


  int countByDepartment(Department department) {
    return state.where((s) => s.department == department).length;
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  return StudentsNotifier();
});

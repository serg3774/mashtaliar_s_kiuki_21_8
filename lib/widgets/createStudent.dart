import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/departments_provider.dart';
import '../models/Department.dart';

class NewStudent extends ConsumerStatefulWidget {
  final Function(Student) onSave;
  final Student? student;

  const NewStudent({Key? key, required this.onSave, this.student})
      : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late Department _selectedDepartment;
  late Gender _selectedGender;
  int _selectedGrade = 1;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.student?.firstName ?? '');
    _lastNameController = TextEditingController(text: widget.student?.lastName ?? '');
    final defaultDepartments = ref.read(departmentsProvider);
    _selectedDepartment = widget.student?.department ?? defaultDepartments.first;
    _selectedGender = widget.student?.gender ?? Gender.male;
    _selectedGrade = widget.student?.grade ?? 1;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newStudent = Student(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      department: _selectedDepartment,
      grade: _selectedGrade,
      gender: _selectedGender,
    );

    widget.onSave(newStudent);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final departments = ref.watch(departmentsProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            DropdownButton<Department>(
              value: _selectedDepartment,
              items: departments.map((dept) {
                return DropdownMenuItem(
                  value: dept,
                  child: Row(
                    children: [
                      Image.asset(dept.icon, width: 24, height: 24),
                      const SizedBox(width: 8),
                      Text(dept.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedDepartment = value!),
            ),
            DropdownButton<Gender>(
              value: _selectedGender,
              items: Gender.values.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender == Gender.male ? 'Male' : 'Female'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Grade:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: _selectedGrade.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _selectedGrade.toString(),
                    onChanged: (value) =>
                        setState(() => _selectedGrade = value.toInt()),
                  ),
                ),
                Text(
                  _selectedGrade.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveStudent,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

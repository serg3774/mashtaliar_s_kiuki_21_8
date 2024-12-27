import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../models/Department.dart';
import '../providers/students_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({
    super.key,
    this.elemIndex
  });

  final int? elemIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  late Department _selectedDepartment;
  Gender _selectedGender = Gender.male;
  int _selectedGrade = 1;

  @override
  void initState() {
    super.initState();
    _selectedDepartment = departmentsList.first;
    if (widget.elemIndex != null) {
      final student = ref.read(studentsProvider).students[widget.elemIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _selectedGrade = student.grade;
      _selectedGender = student.gender;
      _selectedDepartment = student.department;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (widget.elemIndex == null)  {
      await ref.read(studentsProvider.notifier).addStudent(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            _selectedGrade,
          );
    } else {
      await ref.read(studentsProvider.notifier).editStudent(
            widget.elemIndex!,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            _selectedGrade,
          );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(studentsProvider);

    if(screenState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
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
              items: departmentsList.map((dept) {
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

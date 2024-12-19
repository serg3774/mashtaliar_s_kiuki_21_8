import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/Department.dart';

final departmentsProvider = Provider<List<Department>>((ref) {
  return [
    Department(id: '1', name: 'IT', color: Colors.blue, icon: 'assets/it.png'),
    Department(id: '2', name: 'Finance', color: Colors.green, icon: 'assets/finance.png'),
    Department(id: '3', name: 'Law', color: Colors.red, icon: 'assets/law.png'),
    Department(id: '4', name: 'Medical', color: Colors.purple, icon: 'assets/medical.png'),
  ];
});

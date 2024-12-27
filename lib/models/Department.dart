import 'package:flutter/material.dart';

class Department {
  final String id;
  final String name;
  final Color color;
  final String icon;

  Department({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}

final departmentsList = [
    Department(id: '1', name: 'IT', color: Colors.blue, icon: 'assets/it.png'),
    Department(id: '2', name: 'Finance', color: Colors.green, icon: 'assets/finance.png'),
    Department(id: '3', name: 'Law', color: Colors.red, icon: 'assets/law.png'),
    Department(id: '4', name: 'Medical', color: Colors.purple, icon: 'assets/medical.png'),
  ];
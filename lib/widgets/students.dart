import 'package:flutter/material.dart';
import 'package:mashtaliar_s_kiuki_21_8/models/student.dart';
import 'package:mashtaliar_s_kiuki_21_8/widgets/createStudent.dart';
import 'package:mashtaliar_s_kiuki_21_8/widgets/students_item.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  StudentListViewState createState() => StudentListViewState();
}

class StudentListViewState extends State<StudentListView> {
  static List<Student> students = [
    Student("Serhii", "Mashtaliar", Gender.male, 4, Department.it),
    Student("Valeriy", "Dmitrenki", Gender.male, 4, Department.finance),
    Student("Illya", "Razievskiy", Gender.male, 5, Department.law),
    Student("Karina", "Lifinceva", Gender.female, 2, Department.medical),
  ];

  void addStudent(Student newStudent) {
    setState(() {
      students.add(newStudent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        final iconPath = icons[student.department];
        final colorName = GenderColor[student.gender];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Dismissible(
              key: Key('${student.firstName}_${student.lastName}_$index'),
              background: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Container(
                      height: 10,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text(
                              "Видалити студента",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]))),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                removeStudent(index);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                      child: InkWell(
                    onTap: () {
                      showNewStudent(context, addStudent, index);
                    },
                    splashColor: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: StudentsItem(
                        firstName: student.firstName,
                        lastName: student.lastName,
                        iconPath: iconPath,
                        colorName: colorName,
                        grade: student.grade,
                      ),
                    ),
                  )))),
        );
      },
    );
  }

  void removeStudent(int index) {
    var removedStudent = students[index];
    setState(() {
      students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Студента видалено'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              students.insert(index, removedStudent);
            });
          }),
    ));
  }
}

import 'package:modelhandling/model/student.dart';

class StudentService{
  Future<List<Student>> fetchStudents() async {
    await Future.delayed(const Duration(seconds: 2));

    final rawData = [
      {'id': '2', 'name': 'lis gwapo', 'age': 20, 'gpa': 1.25},
      {'id': '3', 'name': 'reynaldo gumamelo', 'age': 20, 'gpa': 1.50},
      {'id': '2', 'name': 'bern ryan babaedor', 'age': 78, 'gpa': 5.25},
    ];

    return rawData.map((data) => Student.fromMap(data)).toList();
  }
}
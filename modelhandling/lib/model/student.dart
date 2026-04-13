class Student {
  final String id;
  final String name;
  final double gpa;
  final String course;

  Student({
    required this.name,
    required this.id,
    required this.gpa,
    required this.course,
  });

  factory Student.fromMap(Map<String, dynamic> map){
    return Student(
      id: map['id'] as String,
      name: map['name'] as String,
      gpa: (map['gpa'] as num).toDouble(),
      course: map['course'] as String

    );
  }
  
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'gpa': gpa,
      'course' : course
    };
  }
}

  
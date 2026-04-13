import 'package:flutter/material.dart';
import 'package:modelhandling/controller/student_controller.dart';
import 'package:modelhandling/model/student_model.dart';



class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final controller = StudentController();
  final nameController = TextEditingController();
  final quizController = TextEditingController();
  final activityController = TextEditingController();
  final examController = TextEditingController();
  final searchController = TextEditingController();

  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  // TO DO: Load students from Supabase
  // 1. Set isLoading to true
  // 2. Call controller.getStudents()
  // 3. Update students and filteredStudents
  // 4. Set isLoading to false
  // Don't forget to use setState()
  void loadStudents() async {
    // YOUR CODE HERE
    setState(() {
      isLoading = true;
    });
    students = await controller.getStudents();
    filteredStudents = students;
    setState(() {
      isLoading = false;
    });
  }

  void searchStudents(String query) {
    setState(() {
      filteredStudents = controller.searchStudents(students, query);
    });
  }

  void addStudent() async {
    if (nameController.text.isEmpty ||
        quizController.text.isEmpty ||
        activityController.text.isEmpty ||
        examController.text.isEmpty) {
      showMessage('Please fill all fields');
      return;
    }

    // TO DO: Create a Student object using the text field values
    // Hint: Use double.parse() to convert String to double
    final student = Student(
      // YOUR CODE HERE
      name: nameController.text,
      quiz: double.parse(quizController.text),
      activity: double.parse(activityController.text),
      exam: double.parse(examController.text),
    );

    await controller.addStudent(student);
    nameController.clear();
    quizController.clear();
    activityController.clear();
    examController.clear();
    showMessage('Student added successfully');
    loadStudents();
  }

  void deleteStudent(int id, String name) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Delete $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // TO DO: Call the delete function from controller
              // YOUR CODE HERE
              await controller.deleteStudent(id);

              showMessage('Student deleted');
              loadStudents();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: quizController,
              decoration: const InputDecoration(
                labelText: 'Quiz',
                prefixIcon: Icon(Icons.quiz),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: activityController,
              decoration: const InputDecoration(
                labelText: 'Activity',
                prefixIcon: Icon(Icons.assignment),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: examController,
              decoration: const InputDecoration(
                labelText: 'Exam',
                prefixIcon: Icon(Icons.school),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              addStudent();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Student Grades'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildSummaryCard(
                      'Class Average',
                      controller.getClassAverage(students).toStringAsFixed(1),
                      Icons.analytics,
                      Colors.blue,
                    ),
                    const SizedBox(width: 10),
                    _buildSummaryCard(
                      'Passed',
                      '${controller.countPassed(students)}',
                      Icons.check_circle,
                      Colors.green,
                    ),
                    const SizedBox(width: 10),
                    _buildSummaryCard(
                      'Failed',
                      '${controller.countFailed(students)}',
                      Icons.cancel,
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: searchController,
                  onChanged: searchStudents,
                  decoration: InputDecoration(
                    hintText: 'Search student...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredStudents.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No students found',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return _buildStudentCard(student);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    final isPassed = student.status == 'Passed';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: isPassed
                          ? Colors.green[100]
                          : Colors.red[100],
                      child: Text(
                        student.name[0].toUpperCase(),
                        style: TextStyle(
                          color: isPassed ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isPassed ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    student.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGradeItem('Quiz', student.quiz),
                _buildGradeItem('Activity', student.activity),
                _buildGradeItem('Exam', student.exam),
                _buildGradeItem('Average', student.average, isAverage: true),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => deleteStudent(student.id!, student.name),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeItem(String label, double value, {bool isAverage = false}) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 5),
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 16,
            fontWeight: isAverage ? FontWeight.bold : FontWeight.normal,
            color: isAverage
                ? (value >= 75 ? Colors.green : Colors.red)
                : Colors.black,
          ),
        ),
      ],
    );
  }
}

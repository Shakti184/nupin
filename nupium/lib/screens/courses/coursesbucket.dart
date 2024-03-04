import 'package:flutter/material.dart';

class CoursesBucketPage extends StatefulWidget {
  const CoursesBucketPage({Key? key}) : super(key: key);

  @override
  _CoursesBucketPageState createState() => _CoursesBucketPageState();
}

class _CoursesBucketPageState extends State<CoursesBucketPage> {
  String? _selectedProgram;
  final List<String> _programs = ['Program A', 'Program B', 'Program C']; // Example list of programs
  final Map<String, List<Course>> _courses = {
    'Program A': [
      Course(name: 'Course 1', startDate: '01/01/2023', endDate: '31/01/2023', details: 'Course 1 details'),
      Course(name: 'Course 2', startDate: '01/02/2023', endDate: '28/02/2023', details: 'Course 2 details'),
    ],
    'Program B': [
      Course(name: 'Course 3', startDate: '01/03/2023', endDate: '31/03/2023', details: 'Course 3 details'),
      Course(name: 'Course 4', startDate: '01/04/2023', endDate: '30/04/2023', details: 'Course 4 details'),
    ],
    'Program C': [
      Course(name: 'Course 5', startDate: '01/05/2023', endDate: '31/05/2023', details: 'Course 5 details'),
      Course(name: 'Course 6', startDate: '01/06/2023', endDate: '30/06/2023', details: 'Course 6 details'),
    ],
  };

  String? _selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses Bucket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedProgram,
              hint: const Text('Select Program'),
              onChanged: (newValue) {
                setState(() {
                  _selectedProgram = newValue;
                  _selectedCourse = null; // Reset selected course when program changes
                });
              },
              items: _programs.map((program) {
                return DropdownMenuItem<String>(
                  value: program,
                  child: Text(program),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            if (_selectedProgram != null)
              DropdownButtonFormField<Course>(
                value: null,
                hint: const Text('Select Course'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCourse = newValue?.name;
                  });
                },
                items: _courses[_selectedProgram!]!.map((course) {
                  return DropdownMenuItem<Course>(
                    value: course,
                    child: Text(course.name),
                  );
                }).toList(),
              ),
            const SizedBox(height: 16.0),
            if (_selectedCourse != null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Course')),
                    DataColumn(label: Text('Start Date')),
                    DataColumn(label: Text('End Date')),
                    DataColumn(label: Text('Details')),
                  ],
                  rows: _courses[_selectedProgram!]!
                      .map((course) => DataRow(cells: [
                            DataCell(Text(course.name)),
                            DataCell(Text(course.startDate)),
                            DataCell(Text(course.endDate)),
                            DataCell(Text(course.details)),
                          ]))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final String startDate;
  final String endDate;
  final String details;

  Course({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.details,
  });
}

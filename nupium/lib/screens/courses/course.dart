import 'package:flutter/material.dart';

import '../../components/course_card.dart';

class CoursePage extends StatefulWidget {
  final Map<String, dynamic> program;

  const CoursePage({Key? key, required this.program}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}


class _CoursePageState extends State<CoursePage> {
  late List<Map<String, dynamic>> courseData;

  @override
  void initState() {
    super.initState();
    final List<dynamic> courseIdsDynamic = widget.program['courseIds'];
    courseData = List<Map<String, dynamic>>.from(courseIdsDynamic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.program['name']),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Courses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: courseData.length,
                itemBuilder: (context, index) {
                  final course = courseData[index];
                  return CourseCard(
                    courseName: course['name'],
                    description: course['description'],
                    price: course['price'],
                    duration: course['duration'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

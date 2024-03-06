import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../components/models/program_course.dart'; // Assuming you have a Course model defined

class CoursesBucketPage extends StatefulWidget {
  const CoursesBucketPage({Key? key}) : super(key: key);

  @override
  State<CoursesBucketPage> createState() => _CoursesBucketPageState();
}

class _CoursesBucketPageState extends State<CoursesBucketPage> {
  Course? _selectedCourse;
  List<Course> _courses = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
  if (!mounted) return; // Check if the widget is still mounted

  setState(() {
    _isLoading = true;
  });
  
  try {
    final dio = Dio();
    final response = await dio.get('http://192.168.1.35:3000/api/courses');

    if (!mounted) return; // Check if the widget is still mounted before updating the state

    if (response.statusCode == 200) {
      setState(() {
        _courses = (response.data as List)
            .map((courseJson) => Course.fromJson(courseJson))
            .toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch courses');
    }
  } catch (error) {
    print('Error fetching courses: $error');
    setState(() {
      _isLoading = false;
    });
  }
}


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
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              DropdownButtonFormField<Course>(
                value: _selectedCourse,
                hint: const Text('Select Course'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCourse = newValue;
                  });
                },
                items: _courses.map((course) {
                  return DropdownMenuItem<Course>(
                    value: course,
                    child: Text(course.name),
                  );
                }).toList(),
              ),
            if (_selectedCourse != null) ...[
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Course Details',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text('Name: ${_selectedCourse!.name}'),
                  Text('Description: ${_selectedCourse!.description}'),
                  Text('Price: \$${_selectedCourse!.price}'),
                  // Add more details as needed
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

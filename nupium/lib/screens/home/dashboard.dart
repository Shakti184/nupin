import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../courses/course.dart';

class DashboardPage extends StatefulWidget {
  final String userEmail;
  final String userName;
  final Animation<Offset> offsetAnimation;

  const DashboardPage({
    Key? key,
    required this.userEmail,
    required this.userName,
    required this.offsetAnimation,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Map<String, dynamic>> programs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrograms();
  }

  Future<void> fetchPrograms() async {
    try {
      final dio = Dio();
      final response = await dio.get('http://192.168.1.35:3000/api/programs');

      if (response.statusCode == 200) {
        setState(() {
          programs = List<Map<String, dynamic>>.from(response.data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch programs');
      }
    } catch (error) {
      print('Error fetching programs: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 171, 185, 255),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                // Handle tap on user info if needed
              },
              child: SlideTransition(
                position: widget.offsetAnimation,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.0,
                        child: Icon(
                          Icons.person,
                          size: 40.0,
                          color:Color.fromARGB(255, 33, 36, 65),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 33, 36, 65),
                            ),
                          ),
                          Text(
                            widget.userEmail,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 33, 36, 65),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Nupium Academy\n',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 249, 249, 250)),
                    ),
                    TextSpan(
                      text: 'Programme your one & only skills\n',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextSpan(
                      text: 'enhancing partner',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(height: 2.0, width: double.infinity, color: const Color.fromARGB(255, 255, 255, 255)),
            const SizedBox(height: 10.0),
            const Center(
              child: Text(
                "List of Programmes",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              ...programs.map((program) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoursePage(program: program),
                          ),
                        );
                      },
                      child: buildBoxRow(program['name'], Icons.school),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildBoxRow(String title, IconData icon) {
    return SizedBox(
      height: 65,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 35.0,
              color: const Color.fromARGB(255, 62, 72, 95),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 62, 72, 95),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

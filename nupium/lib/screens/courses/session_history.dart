import 'package:flutter/material.dart';

class SessionHistoryPage extends StatefulWidget {
  const SessionHistoryPage({Key? key}) : super(key: key);

  @override
  State<SessionHistoryPage> createState() => _SessionHistoryPageState();
}

class _SessionHistoryPageState extends State<SessionHistoryPage> {
  String? _selectedProgram;
  String? _selectedCourse;

  final List<String> _programs = ['Program A', 'Program B']; // Example list of programs
  final Map<String, List<String>> _courses = {
    'Program A': ['Course 1', 'Course 2', 'Course 3'], // Example list of courses for each program
    'Program B': ['Course 4', 'Course 5', 'Course 6'],
  };

  final List<SessionHistory> _sessionHistories = [
    SessionHistory(
      date: '12/07/2023',
      time: '03:00 pm to 04:00 pm',
      session: '1',
      trainingPlatform: 'Zoom Meeting',
      filesDownload: '1GB File Space',
      accessToCourse: 'Certificate',
    ),
    SessionHistory(
      date: '13/07/2023',
      time: '04:00 pm to 05:00 pm',
      session: '2',
      trainingPlatform: 'Google Meet',
      filesDownload: '500MB File Space',
      accessToCourse: 'Certificate',
    ),
    // Add more session histories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session History'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                  DropdownButtonFormField<String>(
                    value: _selectedCourse,
                    hint: const Text('Select Course'),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCourse = newValue;
                      });
                    },
                    items: _courses[_selectedProgram!]!.map((course) {
                      return DropdownMenuItem<String>(
                        value: course,
                        child: Text(course),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Session')),
                  DataColumn(label: Text('Training Platform')),
                  DataColumn(label: Text('Files Download')),
                  DataColumn(label: Text('Get Access to Your Course')),
                ],
                rows: _sessionHistories.map((session) {
                  return DataRow(cells: [
                    DataCell(Text(session.date)),
                    DataCell(Text(session.time)),
                    DataCell(Text(session.session)),
                    DataCell(Text(session.trainingPlatform)),
                    DataCell(Text(session.filesDownload)),
                    DataCell(Text(session.accessToCourse)),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SessionHistory {
  final String date;
  final String time;
  final String session;
  final String trainingPlatform;
  final String filesDownload;
  final String accessToCourse;

  SessionHistory({
    required this.date,
    required this.time,
    required this.session,
    required this.trainingPlatform,
    required this.filesDownload,
    required this.accessToCourse,
  });
}

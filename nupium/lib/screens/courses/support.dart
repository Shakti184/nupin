import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SupportAccountPage extends StatefulWidget {
  const SupportAccountPage({Key? key}) : super(key: key);

  @override
  State<SupportAccountPage> createState() => _SupportAccountPageState();
}

class _SupportAccountPageState extends State<SupportAccountPage> {
  String? _selectedCourseType;
  String? _selectedProblemType;
  final TextEditingController _descriptionController = TextEditingController();
  String _attachedDocument = '';

  // Mock data for course types and problem types
  final List<String> _courseTypes = ['Course A', 'Course B', 'Course C'];
  final List<String> _problemTypes = [
    'Courses',
    'Account',
    'Payment',
    'Other',
    'Placement Advice',
    'Complaint',
    'Video Counselling',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'If you have any questions related to your subscription and account raise ticket',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Email us at: support@nupiumacademy.com',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Candidate Helpline: +1 xxxxxxxx',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCourseType,
              items: _courseTypes.map((String courseType) {
                return DropdownMenuItem<String>(
                  value: courseType,
                  child: Text(courseType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCourseType = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Course Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedProblemType,
              items: _problemTypes.map((String problemType) {
                return DropdownMenuItem<String>(
                  value: problemType,
                  child: Text(problemType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProblemType = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Problem Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _attachDocument();
              },
              child: const Text('Attach Document'),
            ),
            const SizedBox(height: 10),
            Text(
              _attachedDocument.isNotEmpty ? 'Attached Document: $_attachedDocument' : '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _submitTicket();
              },
              child: const Text('Submit Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  void _attachDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          _attachedDocument = file.name;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error picking file: $e');
      }
    }
  }

  void _submitTicket() {
    // Validate fields
    if (_selectedCourseType == null || _selectedProblemType == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Implement logic to submit the ticket
    // You can access the selected course type, problem type, description, and attached document here
    // For example, you can send an email with the ticket details
    // Make sure to validate the fields before submitting

    // Reset fields
    setState(() {
      _selectedCourseType = null;
      _selectedProblemType = null;
      _descriptionController.clear();
      _attachedDocument = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ticket submitted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

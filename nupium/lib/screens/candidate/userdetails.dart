import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nupium/screens/home/homepage.dart';

class UserDetailsPage extends StatefulWidget {
  final String userId;

  const UserDetailsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}


class _UserDetailsPageState extends State<UserDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  // Define category types and program types as lists
  List<String> categoryTypes = ['Web 3', 'Corporate Solutions'];
  List<String> programTypes = ['Introduction', 'Diploma', 'Degree'];

  String? _selectedCategoryType;
  String? _selectedProgramType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCategoryType,
                hint: const Text('Select Category Type'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategoryType = newValue;
                  });
                },
                items: categoryTypes.map((categoryType) {
                  return DropdownMenuItem<String>(
                    value: categoryType,
                    child: Text(categoryType),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                value: _selectedProgramType,
                hint: const Text('Select Programme Type'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedProgramType = newValue;
                  });
                },
                items: programTypes.map((programType) {
                  return DropdownMenuItem<String>(
                    value: programType,
                    child: Text(programType),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, proceed with form submission
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    String contact = _contactController.text;
                    String country = _countryController.text;

                    // Store user details in Firestore
                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .set({
                        'categoryType': _selectedCategoryType,
                        'programType': _selectedProgramType,
                        'firstName': firstName,
                        'lastName': lastName,
                        'contact': contact,
                        'country': country,
                        // Add other user data fields
                      });

                      // Navigate to the home page after saving user details
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                    } catch (error) {
                      print('Error storing user details: $error');
                      // Show error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Error saving user details. Please try again later.'),
                      ));
                    }
                  }
                },
                child: const Text('Save Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

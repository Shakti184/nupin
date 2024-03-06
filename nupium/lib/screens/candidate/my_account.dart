import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  late String _userName = ''; 
  late String _userEmail = '';
  late String _profileImage = '';
  late bool _hasPurchasedCourses = false;
  late String _categoryType = '';
  late String _programmeType = '';
  late String _firstName = '';
  late String _lastName = '';
  late String _contact = '';
  late String _country = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Get the current user ID from the authentication provider
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      
      if (userId.isNotEmpty) {
        DocumentSnapshot userDataSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(userId).get();
        var userData = userDataSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _userName = userData['user_name'] ?? ''; 
          _userEmail = userData['email'] ?? '';
          _profileImage = userData['profile_image'] ?? '';
          _hasPurchasedCourses = userData['has_purchased_courses'] ?? false;
          _categoryType = userData['category_type'] ?? '';
          _programmeType = userData['programme_type'] ?? '';
          _firstName = userData['first_name'] ?? '';
          _lastName = userData['last_name'] ?? '';
          _contact = userData['contact'] ?? '';
          _country = userData['country'] ?? '';
          _isLoading = false; // Set loading indicator to false
        });
      } else {
        // User ID is empty, set loading indicator to false
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      // Print error if fetching user data fails
      print('Error fetching user data: $error');
      // Set loading indicator to false
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Center(
        child: _isLoading 
            ? const CircularProgressIndicator() // Show loading indicator while fetching data
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_profileImage),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'User Name: $_userName',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Email: $_userEmail',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Category Type: $_categoryType',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Programme Type: $_programmeType',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'First Name: $_firstName',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Last Name: $_lastName',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Contact: $_contact',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Country: $_country',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}

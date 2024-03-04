import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  // Mock data for the user profile
  final String _userName = "John Doe";
  final String _userEmail = "john.doe@example.com";
  final String _profileImage = "assets/bird_2.jpg";
  final bool _hasPurchasedCourses = true; // Change this based on user's purchase status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(_profileImage),
            ),
            const SizedBox(height: 20),
            Text(
              _userName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              _userEmail,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            _hasPurchasedCourses
                ? Text(
                    'You have purchased courses.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : Text(
                    'You have not purchased any courses yet.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ],
        ),
      ),
    );
  }
}

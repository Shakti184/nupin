import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nupium/screens/candidate/userdetails.dart';

import '../../components/helper.dart';
import '../../components/rounded_input_field.dart';
import '../home/homepage.dart';
import 'forgotpassword.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  bool _showPassword = false;
  String userId="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Nupium Acadmy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200.0,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  'assets/bird_2.jpg', // Replace with the actual image asset path
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  RoundedInputField(
                    labelText: 'Username',
                    obscureText: false,
                    borderRadius: 40.0,
                    controller: _usernameController,
                    suffixIcon: null, // No suffix icon for username
                  ),
                  const SizedBox(height: 16.0),
                  RoundedInputField(
                    labelText: 'Email',
                    obscureText: false,
                    borderRadius: 40.0,
                    controller: _userEmailController,
                    suffixIcon: null, // No suffix icon for email
                  ),
                  const SizedBox(height: 16.0),
                  RoundedInputField(
                    labelText: 'Password',
                    obscureText: !_showPassword,
                    borderRadius: 40.0,
                    controller: _passwordController,
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _performSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          // Change color as needed
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSignUp() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String email = _userEmailController.text;

    if (username == "" || password == "" || email == "") {
      Helper.customAlertBox(context, "Enter The Required Fields");
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userId = userCredential.user!.uid;
      // Update user's display name
      await userCredential.user?.updateDisplayName(username);

      // Navigate to HomePage after successful sign-up
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => UserDetailsPage(userId: userId)),
      (route) => false,
    );
    } on FirebaseAuthException catch (e) {
      Helper.customAlertBox(context, e.code.toString());
    }
  }
}

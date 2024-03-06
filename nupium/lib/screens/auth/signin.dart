import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/rounded_input_field.dart';
import '../home/homepage.dart';
import 'forgotpassword.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Nupium Acadmy',style: TextStyle(fontWeight: FontWeight.bold),)),
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
                    labelText: 'Email',
                    obscureText: false,
                    borderRadius: 40.0,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16.0),
                  RoundedInputField(
                    labelText: 'Password',
                    obscureText:!_showPassword,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
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
                        onPressed: () {
                          _performLogin();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.lightBlue,
                           // Change color as needed
                        ),
                        child: const Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                              (route) => false);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
  void _performLogin() async {
   try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the home page upon successful authentication
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      // Show an error dialog for authentication failure
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Authentication Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    
  }
}
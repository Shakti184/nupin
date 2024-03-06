import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nupium/screens/auth/signin.dart';
import '../candidate/my_account.dart';
import '../courses/coursesbucket.dart';
import 'dashboard.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late String _userEmail = '';
  late String _userName = ''; // Add user name variable

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Fetch the current user's data
    _fetchUserData(context);
  }

  Future<void> _fetchUserData(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email ?? '';
        _userName = user.displayName ?? ''; // Assign user's name if available
      });
    }
  }

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const SignInPage()),(route) => false,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        toolbarHeight: 80,
        title: const Text('Welcome Shakti to Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _toggleProfileAnimation(); // Handle profile button click
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      drawer: DrawerPage(userName: _userName, userEmail: _userEmail),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          DashboardPage(
            offsetAnimation: _offsetAnimation,
            userEmail: _userEmail,
            userName: _userName, // Pass user's name to DashboardPage
          ),
          
          const CoursesBucketPage (),
          const MyAccountPage (),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'My Account',
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  void _toggleProfileAnimation() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }
}

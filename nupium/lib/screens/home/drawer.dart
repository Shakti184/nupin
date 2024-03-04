import 'package:flutter/material.dart';
import 'package:nupium/components/helper.dart';
import 'package:nupium/screens/courses/help.dart';
import 'package:nupium/screens/courses/subscription.dart';
import 'package:nupium/screens/courses/support.dart';
import '../candidate/my_account.dart';
import '../courses/coursesbucket.dart';
import '../courses/payment.dart';
import '../courses/session_history.dart';

class DrawerPage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const DrawerPage({Key? key, required this.userName, required this.userEmail})
      : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String image = "assets/bird_2.jpg";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.redAccent,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    shadowColor: Colors.red,
                    child: Image.asset(
                      image,
                      filterQuality: FilterQuality.high,
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.userEmail,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Helper.buildDrawerItem(context,'My Account', const MyAccountPage()),
                Helper.buildDrawerItem(context,'Payment', const PaymentPage()),
                Helper.buildDrawerItem(context,'Subscription', const SubscriptionPage()),
                Helper.buildDrawerItem(context,'Session History', const SessionHistoryPage()),
                Helper.buildDrawerItem(context, 'Courses Bucket', const CoursesBucketPage()),
                Helper.buildDrawerItem(context, 'Support Account', const SupportAccountPage()),
                Helper.buildDrawerItem(context, 'Help', const HelpPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questions You May Have - Everything You Need To Know',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildFAQItem('Q1. How does I signup?', 'You can sign up by visiting our website and clicking on the signup button.'),
              _buildFAQItem('Q2. What methods of payment do you accept?', 'We accept various methods of payment including credit card, debit card, and PayPal.'),
              _buildFAQItem('Q3. How do I cancel course subscription?', 'You can cancel your course subscription by going to your account settings and selecting the cancel subscription option.'),
              _buildFAQItem('Q4. What do you mean by course name?', 'The course name refers to the title or name of the course.'),
              _buildFAQItem('Q5. How do I retrieve my username or password?', 'You can retrieve your username or password by clicking on the forgot password link on the login page and following the instructions.'),
              _buildFAQItem('Q6. What if I don’t pay my subscription fees?', 'If you don’t pay your subscription fees, your access to the course materials may be restricted.'),
              _buildFAQItem('Q7. How do I update my account information?', 'You can update your account information by logging into your account and going to the account settings.'),
              _buildFAQItem('Q8. What if I didn’t satisfy with the course?', 'If you are not satisfied with the course, please contact our support team for assistance.'),
              _buildFAQItem('Q9. How will I be beneficial by taking the course?', 'Our courses are designed to provide valuable knowledge and skills that can help you in your personal and professional life.'),
              _buildFAQItem('Q10. Will you add more kinds of programs in the future?', 'Yes, we are constantly working on adding new programs and courses to our platform.'),
              const SizedBox(height: 20),
              const Text(
                'Still not found what you were looking for? Raise your ticket now to get help.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Add button or link to raise a ticket
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(answer),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

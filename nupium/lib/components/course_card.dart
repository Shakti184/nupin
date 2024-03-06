import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String courseName;
  final String description;
  final int price;
  final int duration;

  const CourseCard({
    Key? key,
    required this.courseName,
    required this.description,
    required this.price,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          courseName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 8),
            Text('Price: \$${price.toString()}'),
            Text('Duration: ${duration.toString()} months'),
          ],
        ),
      ),
    );
  }
}

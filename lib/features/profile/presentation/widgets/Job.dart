import 'package:flutter/material.dart';

class Job extends StatelessWidget {
  final String role;
  final String startDate;
  final String endDate;
  final String company;
  final String description;

  const Job({
    Key? key,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.company,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              role,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              "${startDate} - ${endDate}",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          company,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

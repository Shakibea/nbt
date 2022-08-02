import 'package:flutter/material.dart';

class OrderDetailsTitle extends StatelessWidget {
  final String title;

  OrderDetailsTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff662D91),
          ),
        ),
      ],
    );
  }
}

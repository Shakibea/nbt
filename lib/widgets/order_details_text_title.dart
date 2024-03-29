import 'package:flutter/material.dart';

import '../utils/colors.dart';

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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff662D91),
            // color: colors['returns'],
          ),
        ),
      ],
    );
  }
}

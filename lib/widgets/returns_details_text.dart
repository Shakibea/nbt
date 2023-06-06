import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ReturnDetailsTitle extends StatelessWidget {
  final String title;

  ReturnDetailsTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Color(0xff662D91),
            color: Color(0xff279758).withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}

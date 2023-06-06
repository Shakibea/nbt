import 'package:flutter/material.dart';

class ReturnDetailsTextContent extends StatelessWidget {
  final String? title;
  const ReturnDetailsTextContent({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

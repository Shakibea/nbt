import 'package:flutter/material.dart';

class OrderDetailsTextContent extends StatelessWidget {
  final String? title;
  const OrderDetailsTextContent({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 14.8,
          ),
        ),
      ],
    );
  }
}

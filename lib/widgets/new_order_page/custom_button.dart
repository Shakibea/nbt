// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CustomButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 330,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xff511C74),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

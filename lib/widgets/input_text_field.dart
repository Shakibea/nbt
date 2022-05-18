import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String textTitle;
  final String textAmount;
  final TextEditingController titleController;
  final TextEditingController amountController;
  final Function handler;

  var controller;

  InputTextField(
      {required this.textTitle,
      required this.textAmount,
      required this.titleController,
      required this.amountController,
      required this.handler});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: textTitle,
          ),
          controller: titleController,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: textAmount,
          ),
          controller: amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => handler,
        ),
      ],
    );
  }
}

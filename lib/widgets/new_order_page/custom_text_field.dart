import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final int? maxLines;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool enabled;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    required this.enabled,
    required this.controller,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(labelText),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

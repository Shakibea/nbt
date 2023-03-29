import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? textFieldKey;
  final String? initialValue;
  final String labelText;
  final int? maxLines;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    required this.enabled,
    this.controller,
    this.validator,
    this.onSaved,
    this.initialValue,
    this.textFieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textFieldColor = const Color(0xff511C74);
    return TextFormField(
      key: Key(textFieldKey.toString()),
      initialValue: initialValue,
      cursorColor: textFieldColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 4),
        label: Text(labelText),
        labelStyle: TextStyle(
          color: textFieldColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textFieldColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textFieldColor,
          ),
        ),
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

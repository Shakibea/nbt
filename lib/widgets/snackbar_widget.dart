import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

SnackBar snackBar(BuildContext context) {
  return SnackBar(
    content: const Text('Oops! Do you need access?'),
    action: SnackBarAction(
      label: 'Sign In',
      onPressed: () {
        Navigator.pushReplacementNamed(context, MyLogin.routeName);
      },
    ),
  );
}

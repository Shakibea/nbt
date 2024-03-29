import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_radio_button.dart';

void getChangePin() async {}

void showAlertDialog(BuildContext context, VoidCallback navigatorFun) async {
  String? pinNumber;
  String? pin;

  final pref = await SharedPreferences.getInstance();
  pinNumber = pref.getString('changePin');

  // print(pinNumber);

  if (pinNumber == null) {
    pin = '1234';
  } else {
    pin = pinNumber;
  }

  final pinController = TextEditingController();
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  void function() {
    if (pinController.text == pin) {
      navigatorFun();

      pinController.text = '';
    }
    // else {
    //   Navigator.pop(context);
    // }
  }

  Widget continueButton = TextButton(
    onPressed: function,
    child: const Text("Continue"),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(label: Text('PIN')),
      controller: pinController,
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

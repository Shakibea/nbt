import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePIN extends StatefulWidget {
  const ChangePIN({Key? key}) : super(key: key);

  static const routeName = '/change-pin';

  @override
  State<ChangePIN> createState() => _ChangePINState();
}

class _ChangePINState extends State<ChangePIN> {
  final _changePinController = TextEditingController();

  @override
  void dispose() {
    _changePinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> setChangePin(String pin) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('changePin', pin);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Change PIN'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: _changePinController,
                decoration: const InputDecoration(
                    label: Text('Change PIN'), border: OutlineInputBorder()),
              ),
              const Divider(),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    setChangePin(_changePinController.text);
                    print(_changePinController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Change PIN'))
            ],
          ),
        ));
  }
}

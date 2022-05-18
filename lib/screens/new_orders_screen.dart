import 'package:flutter/material.dart';

class NewOrdersScreen extends StatelessWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/new-orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Orders'),
      ),
    );
  }
}

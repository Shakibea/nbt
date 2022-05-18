import 'package:flutter/material.dart';
import 'package:nbt/widgets/app_bar_functions.dart';

class NewOrdersScreen extends StatelessWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/new-orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForNewOrder('CREATE NEW ORDER'),
    );
  }
}

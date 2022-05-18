import 'package:flutter/material.dart';

import '../widgets/app_bar_functions.dart';

class OldOrdersScreen extends StatelessWidget {
  OldOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/old-orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForNewOrder('OLD ORDERS'),
    );
  }
}

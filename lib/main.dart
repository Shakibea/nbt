import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/transactions.dart';
import './screens/po_list_screen.dart';
import './screens/new_orders_screen.dart';
import './screens/main_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Transactions(),
      child: MaterialApp(
        title: 'NBT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainDashboardScreen(),
        routes: {
          NewOrdersScreen.routeName: (_) => NewOrdersScreen(),
          POListScreen.routeName: (_) => POListScreen(),
        },
      ),
    );
  }
}

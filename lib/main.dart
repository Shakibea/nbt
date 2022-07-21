import 'package:flutter/material.dart';
import 'package:nbt/providers/inventories.dart';
import 'package:nbt/providers/requisitions.dart';
import 'package:nbt/screens/inventory_details_screen.dart';
import 'package:nbt/screens/inventory_screen.dart';
import 'package:nbt/screens/new_inventory_screen.dart';
import 'package:nbt/screens/new_requisition_screen.dart';
import 'package:nbt/screens/order_details_screen.dart';
import 'package:nbt/screens/requisition_details_screen.dart';
import 'package:nbt/screens/requisition_screen.dart';
import 'package:provider/provider.dart';

import './providers/transactions.dart';
import './screens/po_list_screen.dart';
import './screens/new_orders_screen.dart';
import './screens/main_dashboard_screen.dart';
import './screens/old_orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Transactions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Requisitions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Inventories(),
        ),
      ],
      // create: (_) => Transactions(),
      child: MaterialApp(
        title: 'NBT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainDashboardScreen(),
        routes: {
          NewOrdersScreen.routeName: (_) => NewOrdersScreen(),
          POListScreen.routeName: (_) => POListScreen(),
          OldOrdersScreen.routeName: (_) => OldOrdersScreen(),
          RequisitionScreen.routeName: (_) => RequisitionScreen(),
          NewRequisitionScreen.routeName: (_) => NewRequisitionScreen(),
          InventoryScreen.routeName: (_) => InventoryScreen(),
          NewInventoryScreen.routeName: (_) => NewInventoryScreen(),
          InventoryDetailsScreen.routeName: (_) => InventoryDetailsScreen(),
          RequisitionDetailsScreen.routeName: (_) => RequisitionDetailsScreen(),
          OrderDetailsScreen.routeName: (_) => OrderDetailsScreen(),
        },
      ),
    );
  }
}

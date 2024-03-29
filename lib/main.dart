// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nbt/dynamic%20form/multi_form.dart';
import 'package:nbt/providers/NewOrderProvider.dart';
import 'package:nbt/providers/products.dart';
import 'package:nbt/screens/change_pin_screen.dart';
import 'package:nbt/screens/edit_order_screen.dart';
import 'package:nbt/screens/edit_requisition_screen.dart';
import 'package:nbt/screens/edit_returns_screen.dart';
import 'package:nbt/screens/login_screen.dart';
import 'package:nbt/screens/new_order_page.dart';
import 'package:nbt/screens/o_order_list_item_screen.dart';
import 'package:nbt/suggestion_page.dart';
import 'package:nbt/utils/utils.dart';
import 'package:nbt/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';

import 'package:nbt/providers/inventories.dart';
import 'package:nbt/providers/requisitions.dart';
import 'package:nbt/providers/returns.dart';
import 'package:nbt/screens/inventory_details_screen.dart';
import 'package:nbt/screens/inventory_screen.dart';
import 'package:nbt/screens/new_inventory_screen.dart';
import 'package:nbt/screens/new_requisition_screen.dart';
import 'package:nbt/screens/new_returns_screen.dart';
import 'package:nbt/screens/o_order_screen.dart';
import 'package:nbt/screens/order_details_screen.dart';
import 'package:nbt/screens/party_details_screen.dart';
import 'package:nbt/screens/requisition_details_screen.dart';
import 'package:nbt/screens/requisition_screen.dart';
import 'package:nbt/screens/returns_screen.dart';
import 'package:nbt/screens/splash_screen.dart';
import 'package:nbt/widgets/custom_radio_button.dart';

import './providers/transactions.dart';
import './screens/po_list_screen.dart';
import './screens/new_orders_screen.dart';
import './screens/main_dashboard_screen.dart';
import './screens/old_orders_screen.dart';
import './screens/returns_details_screen.dart';
import 'dynamic form/DynamicProductForm.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: 'AIzaSyBzH6teijKpJQIIZ9G860VD5KbFNWF1In0',
  //       appId: "1:840002168632:web:e37c24dc9f2787bf6e43cd",
  //       messagingSenderId: "840002168632",
  //       projectId: "nbt-flutter",
  //       storageBucket: "nbt-flutter.appspot.com",
  //     ),
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Transactions(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Requisitions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Inventories(),
        ),
        ChangeNotifierProvider(
          create: (_) => Returns(),
        ),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
      ],
      // create: (_) => Transactions(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'NBT',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          dividerColor: Colors.transparent,
        ),
        // theme: CupertinoThemeData(
        //   scaffoldBackgroundColor: Colors.white,
        //     // dividerColor: Colors.transparent,
        // ),
        home: SplashScreen(),
        // home: MultiForm(),
        // home: DynamicProductForm(),
        // home: POListScreen(),
        // home: SuggestionPage(),
        routes: {
          MainDashboardScreen.routeName: (_) => MainDashboardScreen(),
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
          ReturnsScreen.routeName: (_) => ReturnsScreen(),
          ReturnsDetailsScreen.routeName: (_) => ReturnsDetailsScreen(),
          EditReturnsScreen.routeName: (context) => EditReturnsScreen(),
          NewReturnsScreen.routeName: (_) => NewReturnsScreen(),
          OOrderScreen.routeName: (_) => OOrderScreen(),
          PartyDetailsScreen.routeName: (_) => PartyDetailsScreen(),
          CustomRadio.routeName: (_) => CustomRadio(),
          EditOrdersScreen.routeName: (_) => EditOrdersScreen(),
          EditRequisitionScreen.routeName: (_) => EditRequisitionScreen(),
          MyLogin.routeName: (_) => MyLogin(),
          ChangePIN.routeName: (_) => ChangePIN(),
          NewOrderPage.routeName: (context) => NewOrderPage(),
          OOrderListItemScreen.routeName: (_) => OOrderListItemScreen([]),
        },
      ),
    );
  }
}

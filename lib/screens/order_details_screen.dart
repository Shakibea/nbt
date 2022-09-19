import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/inventories.dart';
import 'package:nbt/screens/edit_order_screen.dart';
import 'package:nbt/screens/po_list_screen.dart';
import 'package:nbt/utils/colors.dart';
import 'package:nbt/widgets/custom_radio_button.dart';
import 'package:nbt/widgets/order_details_text_content.dart';
import 'package:nbt/widgets/order_details_text_title.dart';
import 'package:nbt/widgets/show_alert_dialog.dart';
import 'package:nbt/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/transaction.dart';
import '../providers/transactions.dart';
import '../widgets/app_bar_functions.dart';
import 'login_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/order-details';

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String;
    // var order = Provider.of<Transactions>(context).findById(orderId);
    var order = Provider.of<Transactions>(context).readSingleOrder(orderId);
    // final deleteOrder = Provider.of<Transactions>(context).deleteOrder(orderId);

    void deleteOrder() {
      Provider.of<Transactions>(context, listen: false).deleteOrder(orderId);
      Navigator.pushReplacementNamed(context, POListScreen.routeName);
    }

    var userRole;
    // bool isUser;
    Future<String?> userCheckFromSharedPref() async {
      final pref = await SharedPreferences.getInstance();
      return pref.getString('user_role');
    }

    // Future<bool> isUserCheck() async {
    //   final role = await userCheckFromSharedPref();
    //   if (role == 'user') {
    //     isUser = true;
    //     // print("your role: $role");
    //   } else {
    //     isUser = false;
    //   }
    //   // print("your role: $role");
    //   return isUser;
    // }

    return Scaffold(
      appBar: appBarForNewOrder('Order Details Page'),
      body: SingleChildScrollView(
        child: FutureBuilder<Transaction1?>(
          future: order,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final order = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    OrderDetailsTitle('Date'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(
                        title: DateFormat.yMMMMd().format(order!.date)),
                    const SizedBox(
                      height: 20,
                    ),

                    //NAME OF PRODUCT
                    OrderDetailsTitle('Name of Product'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(title: order.productName),
                    const SizedBox(
                      height: 20,
                    ),

                    //PARTY NAME
                    OrderDetailsTitle('Party Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(title: order.partyName),
                    const SizedBox(
                      height: 20,
                    ),

                    //FACTORY NAME
                    OrderDetailsTitle('Factory Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(title: order.factoryName),
                    const SizedBox(
                      height: 20,
                    ),

                    //ADDRESS
                    OrderDetailsTitle('Address'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(title: order.address),
                    const SizedBox(
                      height: 20,
                    ),

                    //QUANTITY
                    OrderDetailsTitle('Quantity'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(title: order.quantity),
                    const SizedBox(
                      height: 20,
                    ),

                    FutureBuilder(
                        future: userCheckFromSharedPref(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.data != 'user') {
                              return Container(
                                child: Column(
                                  children: [
                                    //PRODUCT DETAILS
                                    OrderDetailsTitle('Product Details'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    OrderDetailsTextContent(
                                        title: order.productDetail),
                                  ],
                                ),
                              );
                            } else {
                              return Text(
                                  'Super & Admin Only can view Description!');
                            }
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            // final userRole;
                            // final pref = await SharedPreferences.getInstance();
                            // userRole = pref.getString('user_role');
                            userRole = await userCheckFromSharedPref();
                            if (user == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(context));
                              return;
                            } else if (userRole == 'member') {
                              final roleCheckMsg = SnackBar(
                                content: const Text(
                                    'Oops! Admin not allowed to create?'),
                                action: SnackBarAction(
                                  label: 'Sign In',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, MyLogin.routeName);
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(roleCheckMsg);
                              return;
                            }
                            showAlertDialog(context, () {
                              Navigator.pushReplacementNamed(
                                context,
                                EditOrdersScreen.routeName,
                                arguments: orderId,
                              );
                            });
                            // if (FirebaseAuth.instance.currentUser != null) {
                            //   showAlertDialog(context, () {
                            //     Navigator.pushReplacementNamed(
                            //       context,
                            //       EditOrdersScreen.routeName,
                            //       arguments: orderId,
                            //     );
                            //   });
                            // } else {
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(snackBar(context));
                            // }
                          },
                          child: Text('Edit'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            // final userRole;
                            // final pref = await SharedPreferences.getInstance();
                            // userRole = pref.getString('user_role');
                            userRole = await userCheckFromSharedPref();
                            if (user == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(context));
                              return;
                            } else if (userRole == 'member') {
                              final roleCheckMsg = SnackBar(
                                content: const Text(
                                    'Oops! Admin not allowed to create?'),
                                action: SnackBarAction(
                                  label: 'Sign In',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, MyLogin.routeName);
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(roleCheckMsg);
                              return;
                            }

                            showAlertDialog(context, deleteOrder);

                            // if (FirebaseAuth.instance.currentUser != null) {
                            //   showAlertDialog(context, deleteOrder);
                            // } else {
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(snackBar(context));
                            // }

                            // Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

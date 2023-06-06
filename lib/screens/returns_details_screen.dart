// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unused_local_variable, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/screens/returns_screen.dart';
import 'package:nbt/widgets/show_alert_dialog.dart';
import 'package:nbt/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/return.dart';
import '../providers/returns.dart';
import '../utils/colors.dart';
import '../widgets/returns_details_text.dart';
import '../widgets/returns_details_text_content.dart';
import 'edit_returns_screen.dart';
import 'login_screen.dart';

class ReturnsDetailsScreen extends StatelessWidget {
  ReturnsDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/returns-details';

  // final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final returnsUid = ModalRoute.of(context)?.settings.arguments as String;
    // print(returnsUid);
    // var order = Provider.of<Transactions>(context).findById(orderId);
    var returnsProduct =
        Provider.of<Returns>(context).readSingleReturn(returnsUid);
    // final deleteOrder = Provider.of<Transactions>(context).deleteOrder(orderId);

    // List products = [];

    // final Query product = FirebaseFirestore.instance
    //     .collection('orders')
    //     .doc(orderId)
    //     .collection('products');

    // var prod = product.snapshots();

    void deleteOrder() {
      Provider.of<Returns>(context, listen: false)
          .deleteRequisition(returnsUid);
      Navigator.pop(context);
      Navigator.popUntil(
        context,
        // POListScreen.routeName,
        ModalRoute.withName(ReturnsScreen.routeName),
        // ModalRoute.withName(
        //   MainDashboardScreen.routeName,
        // ),
      );
      // Navigator.of(context).pop();
    }

    // void deleteProduct(String productId) {
    //   Provider.of<Products>(context, listen: false).deleteProduct(
    //     orderId,
    //     productId,
    //   );
    //   Navigator.pop(context);
    // }

    String? userRole;
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
      appBar: AppBar(
        title: const Text('Returns Details Page'),
        backgroundColor: colors['returns'],
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // final user = FirebaseAuth.instance.currentUser;
        //       // if (user == null) {
        //       //   ScaffoldMessenger.of(context).showSnackBar(snackBar(context));
        //       //   return;
        //       // }
        //       // Navigator.pushNamed(context, NewReturnsScreen.routeName);
        //     },
        //     icon: const Icon(Icons.add),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Return?>(
          future: returnsProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final returnsT = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ReturnDetailsTitle('Date'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(
                      title: DateFormat.yMMMMd().format(returnsT!.date),
                    ),
                    const SizedBox(height: 8),
                    ReturnDetailsTitle('Returns Number'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(title: returnsT.id),
                    const SizedBox(height: 8),
                    // Product Name
                    ReturnDetailsTitle('Name of Product'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(
                        title: returnsT.productName.toString()),
                    const SizedBox(height: 8),
                    //PARTY NAME
                    ReturnDetailsTitle('Party Name'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(
                        title: returnsT.partyName.toString()),
                    const SizedBox(height: 8),

                    //FACTORY NAME
                    ReturnDetailsTitle('Factory Name'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(
                      title: returnsT.factoryName.isEmpty
                          ? 'None'
                          : returnsT.factoryName.toString(),
                    ),
                    const SizedBox(height: 8),
                    // Requested Quantity
                    ReturnDetailsTitle('Requested Quantity'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(
                      title: returnsT.quantity.toString(),
                    ),
                    const SizedBox(height: 8),
                    // Remarks
                    ReturnDetailsTitle('Remarks'),
                    const SizedBox(height: 4),
                    ReturnDetailsTextContent(
                      title: returnsT.remarks.isEmpty
                          ? 'No Remarks'
                          : returnsT.remarks.toString(),
                    ),
                    const SizedBox(height: 45),
                    // FutureBuilder(
                    //     future: userCheckFromSharedPref(),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return const CircularProgressIndicator();
                    //       } else {
                    //         if (snapshot.data != 'user') {
                    //           return Column(
                    //             children: [
                    //               //PRODUCT DETAILS
                    //               OrderDetailsTitle('Product Details'),
                    //               const SizedBox(
                    //                 height: 10,
                    //               ),
                    //               OrderDetailsTextContent(
                    //                   title: order.productDetail),
                    //             ],
                    //           );
                    //         } else {
                    //           return const Text(
                    //               'Super & Admin Only can view Description!');
                    //         }
                    //       }
                    //     }),
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
                                EditReturnsScreen.routeName,
                                arguments: returnsUid,
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
                          child: const Text('Edit'),
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
                    const SizedBox(height: 15),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

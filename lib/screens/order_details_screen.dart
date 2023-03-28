// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unused_local_variable, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/products.dart';
import 'package:nbt/screens/edit_order_screen.dart';
import 'package:nbt/screens/po_list_screen.dart';
import 'package:nbt/widgets/order_details_text_content.dart';
import 'package:nbt/widgets/order_details_text_title.dart';
import 'package:nbt/widgets/show_alert_dialog.dart';
import 'package:nbt/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/product.dart';
import '../providers/transaction.dart';
import '../providers/transactions.dart';
import '../widgets/app_bar_functions.dart';
import '../widgets/new_order_page/custom_text_field.dart';
import 'edit_product_screen.dart';
import 'login_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/order-details';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String;
    // var order = Provider.of<Transactions>(context).findById(orderId);
    var order = Provider.of<Transactions>(context).readSingleOrder(orderId);
    // final deleteOrder = Provider.of<Transactions>(context).deleteOrder(orderId);

    // List products = [];

    final Query product = FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .collection('products');

    // var prod = product.snapshots();

    void deleteOrder() {
      Provider.of<Transactions>(context, listen: false).deleteOrder(orderId);
      Navigator.pushReplacementNamed(context, POListScreen.routeName);
    }

    void deleteProduct(String productId) {
      Provider.of<Products>(context, listen: false).deleteProduct(
        orderId,
        productId,
      );
      Navigator.pop(context);
    }

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
                    OrderDetailsTitle('PO Number'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(title: order.id),
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
                    OrderDetailsTextContent(title: order.factoryName ?? 'None'),
                    const SizedBox(
                      height: 20,
                    ),
                    //ADDRESS
                    OrderDetailsTitle('Address'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(
                        title: order.address ?? 'No Address'),
                    const SizedBox(
                      height: 20,
                    ),
                    // Transportation
                    OrderDetailsTitle('Transportation'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(
                      title: order.transportation ?? 'No Transportation',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 30,
                    ),
                    OrderDetailsTitle('Product Summary'),
                    const SizedBox(
                      height: 15,
                    ),
                    // OrderDetailsTextContent(title: order.productName),
                    // SizedBox(height: 10),
                    StreamBuilder(
                      stream: product.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                        if (snapShot.hasData) {
                          final snap = snapShot.data!.docs;
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              // padding: EdgeInsets.symmetric(vertical: 20),
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                final document = snap
                                    .map((e) => Product.fromJson(
                                        e.data() as Map<String, dynamic>))
                                    .toList();

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListTile(
                                    // leading: ConstrainedBox(
                                    //   constraints: BoxConstraints(
                                    //     minWidth: 14,
                                    //     minHeight: 14,
                                    //     maxWidth: 24,
                                    //     maxHeight: 24,
                                    //   ),
                                    //   child: Center(child: Text('${index + 1}')),
                                    // ),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xff511C74),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      document[index].name.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Price: ৳ ${document[index].price.toStringAsFixed(2)} \nQty: ${document[index].quantity} Kg',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    //NAME OF PRODUCT
                    OrderDetailsTitle('Product Table'),
                    const SizedBox(
                      height: 15,
                    ),
                    // OrderDetailsTextContent(title: order.productName),
                    // SizedBox(height: 10),
                    StreamBuilder(
                      stream: product.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                        if (snapShot.hasData) {
                          final snap = snapShot.data!.docs;
                          return Container(
                            height: 500,
                            width: double.infinity,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                // padding: EdgeInsets.symmetric(vertical: 20),
                                itemCount: snap.length,
                                itemBuilder: (context, index) {
                                  final document = snap
                                      .map((e) => Product.fromJson(
                                          e.data() as Map<String, dynamic>))
                                      .toList();

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0),
                                    // child: ListTile(
                                    //   // leading: ConstrainedBox(
                                    //   //   constraints: BoxConstraints(
                                    //   //     minWidth: 14,
                                    //   //     minHeight: 14,
                                    //   //     maxWidth: 24,
                                    //   //     maxHeight: 24,
                                    //   //   ),
                                    //   //   child: Center(child: Text('${index + 1}')),
                                    //   // ),
                                    //   leading: CircleAvatar(
                                    //     radius: 20,
                                    //     backgroundColor: Color(0xff511C74),
                                    //     child: Center(
                                    //       child: Text(
                                    //         '${index + 1}',
                                    //         style: TextStyle(
                                    //           fontSize: 18,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   title: Text(
                                    //     document[index].name.toString(),
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 17,
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     'Price: ৳ ${document[index].price.toStringAsFixed(2)} \nQty: ${document[index].quantity} Kg',
                                    //     style: TextStyle(
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w700,
                                    //     ),
                                    //   ),
                                    //   trailing: Row(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: [
                                    //       IconButton(
                                    //         onPressed: () async {
                                    //           final user = FirebaseAuth
                                    //               .instance.currentUser;
                                    //           // final userRole;
                                    //           // final pref = await SharedPreferences.getInstance();
                                    //           // userRole = pref.getString('user_role');
                                    //           userRole =
                                    //               await userCheckFromSharedPref();
                                    //           if (user == null) {
                                    //             ScaffoldMessenger.of(context)
                                    //                 .showSnackBar(
                                    //                     snackBar(context));
                                    //             return;
                                    //           } else if (userRole == 'member') {
                                    //             final roleCheckMsg = SnackBar(
                                    //               content: const Text(
                                    //                   'Oops! Admin not allowed to create?'),
                                    //               action: SnackBarAction(
                                    //                 label: 'Sign In',
                                    //                 onPressed: () {
                                    //                   Navigator
                                    //                       .pushReplacementNamed(
                                    //                           context,
                                    //                           MyLogin.routeName);
                                    //                 },
                                    //               ),
                                    //             );
                                    //             ScaffoldMessenger.of(context)
                                    //                 .showSnackBar(roleCheckMsg);
                                    //             return;
                                    //           }
                                    //           showAlertDialog(context, () {
                                    //             Navigator.pushReplacement(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     EditProductScreen(
                                    //                   productId:
                                    //                       document[index].id,
                                    //                   orderId: orderId,
                                    //                 ),
                                    //               ),
                                    //             );
                                    //             print(document[index].id);
                                    //           });
                                    //         },
                                    //         icon: Icon(Icons.edit),
                                    //       ),
                                    //       IconButton(
                                    //           icon: Icon(
                                    //             Icons.delete,
                                    //             color: Colors.red,
                                    //           ),
                                    //           // _removeProduct(index);
                                    //           onPressed: () async {
                                    //             final user = FirebaseAuth
                                    //                 .instance.currentUser;
                                    //             // final userRole;
                                    //             // final pref = await SharedPreferences.getInstance();
                                    //             // userRole = pref.getString('user_role');
                                    //             userRole =
                                    //                 await userCheckFromSharedPref();
                                    //             if (user == null) {
                                    //               ScaffoldMessenger.of(context)
                                    //                   .showSnackBar(
                                    //                       snackBar(context));
                                    //               return;
                                    //             } else if (userRole == 'member') {
                                    //               final roleCheckMsg = SnackBar(
                                    //                 content: const Text(
                                    //                     'Oops! Admin not allowed to create?'),
                                    //                 action: SnackBarAction(
                                    //                   label: 'Sign In',
                                    //                   onPressed: () {
                                    //                     Navigator
                                    //                         .pushReplacementNamed(
                                    //                             context,
                                    //                             MyLogin
                                    //                                 .routeName);
                                    //                   },
                                    //                 ),
                                    //               );
                                    //               ScaffoldMessenger.of(context)
                                    //                   .showSnackBar(roleCheckMsg);
                                    //               return;
                                    //             }
                                    //
                                    //             showAlertDialog(
                                    //               context,
                                    //               () {
                                    //                 deleteProduct(
                                    //                     document[index].id);
                                    //               },
                                    //             );
                                    //           }),
                                    //     ],
                                    //   ),
                                    // ),
                                    child: Card(
                                      elevation: 2,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.78,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  Color(0xff511C74),
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            // Product Name
                                            CustomTextField(
                                              initialValue:
                                                  document[index].name,
                                              labelText: 'Name of Product',
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              enabled: false,
                                            ),
                                            SizedBox(height: 15),
                                            // Quantity
                                            CustomTextField(
                                              initialValue:
                                                  document[index].quantity,
                                              labelText: 'Quantity (KG)',
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              enabled: false,
                                            ),
                                            SizedBox(height: 15),
                                            // Price
                                            CustomTextField(
                                              initialValue: document[index]
                                                  .price
                                                  .toString(),
                                              labelText: 'Price',
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              enabled: false,
                                            ),
                                            SizedBox(height: 15),
                                            // Description
                                            CustomTextField(
                                              initialValue:
                                                  document[index].description,
                                              labelText: 'Description',
                                              textInputAction:
                                                  TextInputAction.done,
                                              enabled: false,
                                              // controller: _descriptionController,
                                              maxLines: 4,
                                              keyboardType:
                                                  TextInputType.multiline,
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    final user = FirebaseAuth
                                                        .instance.currentUser;
                                                    // final userRole;
                                                    // final pref = await SharedPreferences.getInstance();
                                                    // userRole = pref.getString('user_role');
                                                    userRole =
                                                        await userCheckFromSharedPref();
                                                    if (user == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar(
                                                                  context));
                                                      return;
                                                    } else if (userRole ==
                                                        'member') {
                                                      final roleCheckMsg =
                                                          SnackBar(
                                                        content: const Text(
                                                            'Oops! Admin not allowed to create?'),
                                                        action: SnackBarAction(
                                                          label: 'Sign In',
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    MyLogin
                                                                        .routeName);
                                                          },
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              roleCheckMsg);
                                                      return;
                                                    }
                                                    showAlertDialog(context,
                                                        () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditProductScreen(
                                                            productId:
                                                                document[index]
                                                                    .id,
                                                            orderId: orderId,
                                                          ),
                                                        ),
                                                      );
                                                      print(document[index].id);
                                                    });
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         EditProductScreen(),
                                                    //   ),
                                                    // );
                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blueAccent,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                TextButton(
                                                  onPressed: () async {
                                                    final user = FirebaseAuth
                                                        .instance.currentUser;
                                                    // final userRole;
                                                    // final pref = await SharedPreferences.getInstance();
                                                    // userRole = pref.getString('user_role');
                                                    userRole =
                                                        await userCheckFromSharedPref();
                                                    if (user == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar(
                                                                  context));
                                                      return;
                                                    } else if (userRole ==
                                                        'member') {
                                                      final roleCheckMsg =
                                                          SnackBar(
                                                        content: const Text(
                                                            'Oops! Admin not allowed to create?'),
                                                        action: SnackBarAction(
                                                          label: 'Sign In',
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    MyLogin
                                                                        .routeName);
                                                          },
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              roleCheckMsg);
                                                      return;
                                                    }

                                                    showAlertDialog(
                                                      context,
                                                      () {
                                                        deleteProduct(
                                                            document[index].id);
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
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

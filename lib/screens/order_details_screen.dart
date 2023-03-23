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

    final Query product = FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .collection('products');

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
                    // Transportation
                    OrderDetailsTitle('Transportation'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailsTextContent(
                      title: order.transportation.toString(),
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
                    //NAME OF PRODUCT
                    OrderDetailsTitle('Product Table'),
                    const SizedBox(
                      height: 10,
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
                            // height: MediaQuery.of(context).size.height * 0.6,
                            height: 450,
                            width: double.infinity,
                            // child: ProductListView(),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                itemCount: snap.length,
                                itemBuilder: (context, index) {
                                  final document = snap
                                      .map((e) => Product.fromJson(
                                          e.data() as Map<String, dynamic>))
                                      .toList();

                                  return Card(
                                    elevation: 2,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.78,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Color(0xff511C74),
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
                                            initialValue: document[index].name,
                                            labelText: 'Name of Product',
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            enabled: false,
                                            // controller: _productNameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Product Name!';
                                              }
                                              return null;
                                            },
                                            // onSaved: (value) {
                                            //   _newOrder = Product(
                                            //     id: _newOrder.id,
                                            //     name: value!,
                                            //     quantity: _newOrder.quantity,
                                            //     price: _newOrder.price,
                                            //     description: _newOrder.description,
                                            //   );
                                            // },
                                          ),
                                          SizedBox(height: 15),
                                          // Quantity
                                          CustomTextField(
                                            initialValue:
                                                document[index].quantity,
                                            labelText: 'Quantity (KG)',
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            enabled: false,
                                            // controller: _quantityController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Quantity!';
                                              }
                                              return null;
                                            },
                                            // onSaved: (value) {
                                            //   _newOrder = Product(
                                            //     id: _newOrder.id,
                                            //     name: _newOrder.name,
                                            //     quantity: value!,
                                            //     price: _newOrder.price,
                                            //     description: _newOrder.description,
                                            //   );
                                            // },
                                          ),
                                          SizedBox(height: 15),
                                          // Price
                                          CustomTextField(
                                            initialValue: document[index]
                                                .price
                                                .toString(),
                                            labelText: 'Price',
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            enabled: false,
                                            // controller: _priceController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Price!';
                                              }
                                              return null;
                                            },
                                            // onSaved: (value) {
                                            //   _newOrder = Product(
                                            //     id: _newOrder.id,
                                            //     name: _newOrder.name,
                                            //     quantity: _newOrder.quantity,
                                            //     price: double.parse(value!),
                                            //     description: _newOrder.description,
                                            //   );
                                            // },
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
                                            // focusNode: _descriptionFocusNode,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter anything';
                                              }
                                              // if (value.length <= 10) {
                                              //   return 'above 10';
                                              // }
                                              return null;
                                            },
                                            // onSaved: (value) {
                                            //   _newOrder = Product(
                                            //     id: _newOrder.id,
                                            //     name: _newOrder.name,
                                            //     quantity: _newOrder.quantity,
                                            //     price: _newOrder.price,
                                            //     description: value!,
                                            //   );
                                            // },
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
                                                            snackBar(context));
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
                                                  showAlertDialog(context, () {
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
                                                    fontWeight: FontWeight.w500,
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
                                                            snackBar(context));
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

                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (_) => AlertDialog(
                                                  //     backgroundColor: Colors.white,
                                                  //     title: Text("Are you sure?"),
                                                  //     content:
                                                  //         Text('To delete this product'),
                                                  //     actions: [
                                                  //       TextButton(
                                                  //         onPressed: () {
                                                  //           Navigator.pop(context);
                                                  //         },
                                                  //         child: Text('No'),
                                                  //       ),
                                                  //       TextButton(
                                                  //         onPressed: () {
                                                  //           // _removeProduct(index);
                                                  //           Navigator.pop(context);
                                                  //         },
                                                  //         child: Text('Yes'),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // );
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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

class ProductListView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  ProductListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.78,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xff511C74),
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
                labelText: 'Name of Product',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                // controller: _productNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Name!';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: value!,
                //     quantity: _newOrder.quantity,
                //     price: _newOrder.price,
                //     description: _newOrder.description,
                //   );
                // },
              ),
              SizedBox(height: 15),
              // Quantity
              CustomTextField(
                labelText: 'Quantity (KG)',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                enabled: true,
                // controller: _quantityController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Quantity!';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: _newOrder.name,
                //     quantity: value!,
                //     price: _newOrder.price,
                //     description: _newOrder.description,
                //   );
                // },
              ),
              SizedBox(height: 15),
              // Price
              CustomTextField(
                labelText: 'Price',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                enabled: true,
                // controller: _priceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Price!';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: _newOrder.name,
                //     quantity: _newOrder.quantity,
                //     price: double.parse(value!),
                //     description: _newOrder.description,
                //   );
                // },
              ),
              SizedBox(height: 15),
              // Description
              CustomTextField(
                labelText: 'Description',
                textInputAction: TextInputAction.done,
                enabled: true,
                // controller: _descriptionController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter anything';
                  }
                  // if (value.length <= 10) {
                  //   return 'above 10';
                  // }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: _newOrder.name,
                //     quantity: _newOrder.quantity,
                //     price: _newOrder.price,
                //     description: value!,
                //   );
                // },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text("Are you sure?"),
                        content: Text('To delete this product'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // _removeProduct(index);
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
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
    //   SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   controller: _scrollController,
    //   child: Row(
    //     children: [
    //       Card(
    //         elevation: 2,
    //         margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(25),
    //         ),
    //         child: Container(
    //           height: 380,
    //           width: 300,
    //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(25),
    //           ),
    //           child: Column(
    //             children: [
    //               // Product Name
    //               CustomTextField(
    //                 labelText: 'Name of Product',
    //                 keyboardType: TextInputType.text,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _productNameController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Product Name!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: value!,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: _newOrder.price,
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Quantity
    //               CustomTextField(
    //                 labelText: 'Quantity (KG)',
    //                 keyboardType: TextInputType.number,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _quantityController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Quantity!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: value!,
    //                 //     price: _newOrder.price,
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Price
    //               CustomTextField(
    //                 labelText: 'Price',
    //                 keyboardType: TextInputType.number,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _priceController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Price!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: double.parse(value!),
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Description
    //               CustomTextField(
    //                 labelText: 'Description',
    //                 textInputAction: TextInputAction.done,
    //                 enabled: true,
    //                 // controller: _descriptionController,
    //                 maxLines: 4,
    //                 keyboardType: TextInputType.multiline,
    //                 // focusNode: _descriptionFocusNode,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter anything';
    //                   }
    //                   // if (value.length <= 10) {
    //                   //   return 'above 10';
    //                   // }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: _newOrder.price,
    //                 //     description: value!,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Edit',
    //                       style: TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.blueAccent,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(width: 10),
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Delete',
    //                       style: TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.red,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Card(
    //         elevation: 2,
    //         margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(25),
    //         ),
    //         child: Container(
    //           height: 380,
    //           width: 300,
    //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(25),
    //           ),
    //           child: Column(
    //             children: [
    //               // Product Name
    //               CustomTextField(
    //                 labelText: 'Name of Product',
    //                 keyboardType: TextInputType.text,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _productNameController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Product Name!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: value!,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: _newOrder.price,
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Quantity
    //               CustomTextField(
    //                 labelText: 'Quantity (KG)',
    //                 keyboardType: TextInputType.number,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _quantityController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Quantity!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: value!,
    //                 //     price: _newOrder.price,
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Price
    //               CustomTextField(
    //                 labelText: 'Price',
    //                 keyboardType: TextInputType.number,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _priceController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Price!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: double.parse(value!),
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Description
    //               CustomTextField(
    //                 labelText: 'Description',
    //                 textInputAction: TextInputAction.done,
    //                 enabled: true,
    //                 // controller: _descriptionController,
    //                 maxLines: 4,
    //                 keyboardType: TextInputType.multiline,
    //                 // focusNode: _descriptionFocusNode,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter anything';
    //                   }
    //                   // if (value.length <= 10) {
    //                   //   return 'above 10';
    //                   // }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: _newOrder.price,
    //                 //     description: value!,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Edit',
    //                       style: TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.blueAccent,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(width: 10),
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Delete',
    //                       style: TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.red,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Card(
    //         elevation: 2,
    //         margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(25),
    //         ),
    //         child: Container(
    //           height: 380,
    //           width: 300,
    //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(25),
    //           ),
    //           child: Column(
    //             children: [
    //               // Product Name
    //               CustomTextField(
    //                 labelText: 'Name of Product',
    //                 keyboardType: TextInputType.text,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _productNameController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Product Name!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: value!,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: _newOrder.price,
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Quantity
    //               CustomTextField(
    //                 labelText: 'Quantity (KG)',
    //                 keyboardType: TextInputType.number,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _quantityController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Quantity!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: value!,
    //                 //     price: _newOrder.price,
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Price
    //               CustomTextField(
    //                 labelText: 'Price',
    //                 keyboardType: TextInputType.number,
    //                 textInputAction: TextInputAction.next,
    //                 enabled: true,
    //                 // controller: _priceController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter Price!';
    //                   }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: double.parse(value!),
    //                 //     description: _newOrder.description,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               // Description
    //               CustomTextField(
    //                 labelText: 'Description',
    //                 textInputAction: TextInputAction.done,
    //                 enabled: true,
    //                 // controller: _descriptionController,
    //                 maxLines: 4,
    //                 keyboardType: TextInputType.multiline,
    //                 // focusNode: _descriptionFocusNode,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Please enter anything';
    //                   }
    //                   // if (value.length <= 10) {
    //                   //   return 'above 10';
    //                   // }
    //                   return null;
    //                 },
    //                 // onSaved: (value) {
    //                 //   _newOrder = Product(
    //                 //     id: _newOrder.id,
    //                 //     name: _newOrder.name,
    //                 //     quantity: _newOrder.quantity,
    //                 //     price: _newOrder.price,
    //                 //     description: value!,
    //                 //   );
    //                 // },
    //               ),
    //               SizedBox(height: 15),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Edit',
    //                       style: TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.blueAccent,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(width: 10),
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Text(
    //                       'Delete',
    //                       style: TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.red,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class ProductList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductForm> _forms = [
      ProductForm(),
      // ProductForm(),
      // ProductForm(),
    ];
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              ProductForm(),
            ],
          );
        },
      ),
    );
  }
}

class ProductForm extends StatefulWidget {
  final Function()? onPressed;
  final Product? product;

  const ProductForm({Key? key, this.onPressed, this.product}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  // var _newOrder = Product(
  //   id: '',
  //   name: '',
  //   quantity: '',
  //   price: double.parse(''),
  //   description: '',
  // );

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          height: 395,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              // Product Name
              CustomTextField(
                labelText: 'Name of Product',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _productNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Name!';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: value!,
                //     quantity: _newOrder.quantity,
                //     price: _newOrder.price,
                //     description: _newOrder.description,
                //   );
                // },
              ),
              SizedBox(height: 15),
              // Quantity
              CustomTextField(
                labelText: 'Quantity (KG)',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _quantityController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Quantity!';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: _newOrder.name,
                //     quantity: value!,
                //     price: _newOrder.price,
                //     description: _newOrder.description,
                //   );
                // },
              ),
              SizedBox(height: 15),
              // Price
              CustomTextField(
                labelText: 'Price',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _priceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Price!';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: _newOrder.name,
                //     quantity: _newOrder.quantity,
                //     price: double.parse(value!),
                //     description: _newOrder.description,
                //   );
                // },
              ),
              SizedBox(height: 15),
              // Description
              CustomTextField(
                labelText: 'Description',
                textInputAction: TextInputAction.done,
                enabled: true,
                controller: _descriptionController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter anything';
                  }
                  // if (value.length <= 10) {
                  //   return 'above 10';
                  // }
                  return null;
                },
                // onSaved: (value) {
                //   _newOrder = Product(
                //     id: _newOrder.id,
                //     name: _newOrder.name,
                //     quantity: _newOrder.quantity,
                //     price: _newOrder.price,
                //     description: value!,
                //   );
                // },
              ),
              SizedBox(height: 15),
              ListTile(
                trailing: Row(
                  children: [
                    TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

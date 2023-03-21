// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      body: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          // height: 395,
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
              ListTile(
                trailing: Row(
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
                      onPressed: () {},
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
      // body: FutureBuilder<Transaction1?>(
      //   future: order,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       final order = snapshot.data;
      //       return Padding(
      //         padding: const EdgeInsets.all(20.0),
      //         child: ListView(
      //           children: [
      //             OrderDetailsTitle('Date'),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             OrderDetailsTextContent(
      //                 title: DateFormat.yMMMMd().format(order!.date)),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //
      //             //PARTY NAME
      //             OrderDetailsTitle('Party Name'),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             OrderDetailsTextContent(title: order.partyName),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //
      //             //FACTORY NAME
      //             OrderDetailsTitle('Factory Name'),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             OrderDetailsTextContent(title: order.factoryName),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //
      //             //ADDRESS
      //             OrderDetailsTitle('Address'),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             OrderDetailsTextContent(title: order.address),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //
      //             // FutureBuilder(
      //             //     future: userCheckFromSharedPref(),
      //             //     builder: (context, snapshot) {
      //             //       if (!snapshot.hasData) {
      //             //         return const CircularProgressIndicator();
      //             //       } else {
      //             //         if (snapshot.data != 'user') {
      //             //           return Column(
      //             //             children: [
      //             //               //PRODUCT DETAILS
      //             //               OrderDetailsTitle('Product Details'),
      //             //               const SizedBox(
      //             //                 height: 10,
      //             //               ),
      //             //               OrderDetailsTextContent(
      //             //                   title: order.productDetail),
      //             //             ],
      //             //           );
      //             //         } else {
      //             //           return const Text(
      //             //               'Super & Admin Only can view Description!');
      //             //         }
      //             //       }
      //             //     }),
      //             const SizedBox(
      //               height: 30,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               children: [
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     final user = FirebaseAuth.instance.currentUser;
      //                     // final userRole;
      //                     // final pref = await SharedPreferences.getInstance();
      //                     // userRole = pref.getString('user_role');
      //                     userRole = await userCheckFromSharedPref();
      //                     if (user == null) {
      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(snackBar(context));
      //                       return;
      //                     } else if (userRole == 'member') {
      //                       final roleCheckMsg = SnackBar(
      //                         content: const Text(
      //                             'Oops! Admin not allowed to create?'),
      //                         action: SnackBarAction(
      //                           label: 'Sign In',
      //                           onPressed: () {
      //                             Navigator.pushReplacementNamed(
      //                                 context, MyLogin.routeName);
      //                           },
      //                         ),
      //                       );
      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(roleCheckMsg);
      //                       return;
      //                     }
      //                     showAlertDialog(context, () {
      //                       Navigator.pushReplacementNamed(
      //                         context,
      //                         EditOrdersScreen.routeName,
      //                         arguments: orderId,
      //                       );
      //                     });
      //                     // if (FirebaseAuth.instance.currentUser != null) {
      //                     //   showAlertDialog(context, () {
      //                     //     Navigator.pushReplacementNamed(
      //                     //       context,
      //                     //       EditOrdersScreen.routeName,
      //                     //       arguments: orderId,
      //                     //     );
      //                     //   });
      //                     // } else {
      //                     //   ScaffoldMessenger.of(context)
      //                     //       .showSnackBar(snackBar(context));
      //                     // }
      //                   },
      //                   child: const Text('Edit'),
      //                 ),
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     final user = FirebaseAuth.instance.currentUser;
      //                     // final userRole;
      //                     // final pref = await SharedPreferences.getInstance();
      //                     // userRole = pref.getString('user_role');
      //                     userRole = await userCheckFromSharedPref();
      //                     if (user == null) {
      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(snackBar(context));
      //                       return;
      //                     } else if (userRole == 'member') {
      //                       final roleCheckMsg = SnackBar(
      //                         content: const Text(
      //                             'Oops! Admin not allowed to create?'),
      //                         action: SnackBarAction(
      //                           label: 'Sign In',
      //                           onPressed: () {
      //                             Navigator.pushReplacementNamed(
      //                                 context, MyLogin.routeName);
      //                           },
      //                         ),
      //                       );
      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(roleCheckMsg);
      //                       return;
      //                     }
      //
      //                     showAlertDialog(context, deleteOrder);
      //
      //                     // if (FirebaseAuth.instance.currentUser != null) {
      //                     //   showAlertDialog(context, deleteOrder);
      //                     // } else {
      //                     //   ScaffoldMessenger.of(context)
      //                     //       .showSnackBar(snackBar(context));
      //                     // }
      //
      //                     // Navigator.pop(context);
      //                   },
      //                   child: const Text('Delete'),
      //                   style: ButtonStyle(
      //                       backgroundColor:
      //                           MaterialStateProperty.all(Colors.red)),
      //                 )
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 30,
      //             ),
      //             //NAME OF PRODUCT
      //             OrderDetailsTitle('Name of Product'),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             OrderDetailsTextContent(title: order.productName),
      //             SizedBox(height: 10),
      //             Card(
      //               elevation: 2,
      //               margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(25),
      //               ),
      //               child: Container(
      //                 height: 395,
      //                 width: double.maxFinite,
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(25),
      //                 ),
      //                 child: Column(
      //                   children: [
      //                     // Product Name
      //                     CustomTextField(
      //                       labelText: 'Name of Product',
      //                       keyboardType: TextInputType.text,
      //                       textInputAction: TextInputAction.next,
      //                       enabled: true,
      //                       // controller: _productNameController,
      //                       validator: (value) {
      //                         if (value!.isEmpty) {
      //                           return 'Please enter Product Name!';
      //                         }
      //                         return null;
      //                       },
      //                       // onSaved: (value) {
      //                       //   _newOrder = Product(
      //                       //     id: _newOrder.id,
      //                       //     name: value!,
      //                       //     quantity: _newOrder.quantity,
      //                       //     price: _newOrder.price,
      //                       //     description: _newOrder.description,
      //                       //   );
      //                       // },
      //                     ),
      //                     SizedBox(height: 15),
      //                     // Quantity
      //                     CustomTextField(
      //                       labelText: 'Quantity (KG)',
      //                       keyboardType: TextInputType.number,
      //                       textInputAction: TextInputAction.next,
      //                       enabled: true,
      //                       // controller: _quantityController,
      //                       validator: (value) {
      //                         if (value!.isEmpty) {
      //                           return 'Please enter Quantity!';
      //                         }
      //                         return null;
      //                       },
      //                       // onSaved: (value) {
      //                       //   _newOrder = Product(
      //                       //     id: _newOrder.id,
      //                       //     name: _newOrder.name,
      //                       //     quantity: value!,
      //                       //     price: _newOrder.price,
      //                       //     description: _newOrder.description,
      //                       //   );
      //                       // },
      //                     ),
      //                     SizedBox(height: 15),
      //                     // Price
      //                     CustomTextField(
      //                       labelText: 'Price',
      //                       keyboardType: TextInputType.number,
      //                       textInputAction: TextInputAction.next,
      //                       enabled: true,
      //                       // controller: _priceController,
      //                       validator: (value) {
      //                         if (value!.isEmpty) {
      //                           return 'Please enter Price!';
      //                         }
      //                         return null;
      //                       },
      //                       // onSaved: (value) {
      //                       //   _newOrder = Product(
      //                       //     id: _newOrder.id,
      //                       //     name: _newOrder.name,
      //                       //     quantity: _newOrder.quantity,
      //                       //     price: double.parse(value!),
      //                       //     description: _newOrder.description,
      //                       //   );
      //                       // },
      //                     ),
      //                     SizedBox(height: 15),
      //                     // Description
      //                     CustomTextField(
      //                       labelText: 'Description',
      //                       textInputAction: TextInputAction.done,
      //                       enabled: true,
      //                       // controller: _descriptionController,
      //                       maxLines: 4,
      //                       keyboardType: TextInputType.multiline,
      //                       // focusNode: _descriptionFocusNode,
      //                       validator: (value) {
      //                         if (value!.isEmpty) {
      //                           return 'Please enter anything';
      //                         }
      //                         // if (value.length <= 10) {
      //                         //   return 'above 10';
      //                         // }
      //                         return null;
      //                       },
      //                       // onSaved: (value) {
      //                       //   _newOrder = Product(
      //                       //     id: _newOrder.id,
      //                       //     name: _newOrder.name,
      //                       //     quantity: _newOrder.quantity,
      //                       //     price: _newOrder.price,
      //                       //     description: value!,
      //                       //   );
      //                       // },
      //                     ),
      //                     SizedBox(height: 15),
      //                     ListTile(
      //                       trailing: Row(
      //                         children: [
      //                           TextButton(
      //                             onPressed: () {},
      //                             child: Text(
      //                               'Edit',
      //                               style: TextStyle(
      //                                 fontSize: 15,
      //                                 color: Colors.blueAccent,
      //                                 fontWeight: FontWeight.w500,
      //                               ),
      //                             ),
      //                           ),
      //                           SizedBox(width: 10),
      //                           TextButton(
      //                             onPressed: () {},
      //                             child: Text(
      //                               'Delete',
      //                               style: TextStyle(
      //                                 fontSize: 15,
      //                                 color: Colors.red,
      //                                 fontWeight: FontWeight.w500,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             // Container(
      //             //   // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      //             //   child: ListView.builder(
      //             //       scrollDirection: Axis.horizontal,
      //             //       // controller: _scrollController,
      //             //       shrinkWrap: true,
      //             //       itemCount: 1,
      //             //       itemBuilder: (BuildContext context, int index) {
      //             //         return Row(
      //             //           children: [
      //             //             ProductForm(),
      //             //           ],
      //             //         );
      //             //       }),
      //             // ),
      //             const SizedBox(
      //               height: 20,
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
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

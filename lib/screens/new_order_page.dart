// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/screens/new_order_products_page.dart';
import 'package:provider/provider.dart';

import '../providers/transaction.dart';
import '../providers/transactions.dart';
import './login_screen.dart';
import '../widgets/new_order_page/custom_text_field.dart';
import '../widgets/new_order_page/custom_button.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({Key? key}) : super(key: key);

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  var _increase = 0;
  final _form = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _poNumController = TextEditingController();
  final _partyNameController = TextEditingController();
  final _factoryNameController = TextEditingController();
  final _addressController = TextEditingController();

  var _newOrder = Transaction1(
    id: '',
    productName: '',
    partyName: '',
    factoryName: '',
    address: '',
    quantity: '',
    productDetail: '',
    date: DateTime.now(),
  );

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _poNumController.dispose();
    _partyNameController.dispose();
    _factoryNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveForm() {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    // Provider.of<Transactions>(context, listen: false).addProduct(_newOrder);
    Provider.of<Transactions>(context, listen: false).createOrder(_newOrder);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong!!"),
            );
          }
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('CREATE NEW ORDER'),
                backgroundColor: const Color(0xff511C74),
                actions: [
                  IconButton(
                    onPressed: _saveForm,
                    icon: const Icon(Icons.save),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      //Date
                      CustomTextField(
                        labelText: 'Date',
                        keyboardType: TextInputType.none,
                        textInputAction: TextInputAction.next,
                        enabled: false,
                        controller: _dateController,
                        onSaved: (value) {
                          _newOrder = Transaction1(
                            id: _newOrder.id,
                            productName: _newOrder.productName,
                            partyName: _newOrder.partyName,
                            factoryName: _newOrder.factoryName,
                            address: _newOrder.address,
                            quantity: _newOrder.quantity,
                            productDetail: _newOrder.productDetail,
                            date: DateTime.now(),
                          );
                        },
                      ),
                      //PO Number
                      CustomTextField(
                        labelText: 'PO Number',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: _poNumController,
                        onSaved: (value) {
                          _newOrder = Transaction1(
                            id: value!,
                            productName: _newOrder.productName,
                            partyName: _newOrder.partyName,
                            factoryName: _newOrder.factoryName,
                            address: _newOrder.address,
                            quantity: _newOrder.quantity,
                            productDetail: _newOrder.productDetail,
                            date: _newOrder.date,
                          );
                        },
                      ),
                      // Product Name
                      // CustomTextField(
                      //   labelText: 'Name of Product',
                      //   keyboardType: TextInputType.text,
                      //   textInputAction: TextInputAction.next,
                      //   enabled: true,
                      //   controller: _dateController,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter Product Name!';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (value) {
                      //     _newOrder = Transaction1(
                      //       id: _newOrder.id,
                      //       productName: value!,
                      //       partyName: _newOrder.partyName,
                      //       factoryName: _newOrder.factoryName,
                      //       address: _newOrder.address,
                      //       quantity: _newOrder.quantity,
                      //       productDetail: _newOrder.productDetail,
                      //       date: _newOrder.date,
                      //     );
                      //   },
                      // ),
                      // Party Name
                      CustomTextField(
                        labelText: 'Party Name',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: _partyNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Product Name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: value!,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              date: _newOrder.date);
                        },
                      ),
                      // Factory Name
                      CustomTextField(
                        labelText: 'Factory Name',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: _factoryNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Product Name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: value!,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              date: _newOrder.date);
                        },
                      ),
                      // Address
                      CustomTextField(
                        labelText: 'Address',
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        // textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: _addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter anything';
                          }
                          // if (value.length <= 10) {
                          //   return 'above 10';
                          // }
                          return null;
                        },
                        onSaved: (value) {
                          _newOrder = Transaction1(
                            id: _newOrder.id,
                            productName: _newOrder.productName,
                            partyName: _newOrder.partyName,
                            factoryName: _newOrder.factoryName,
                            address: value!,
                            quantity: _newOrder.quantity,
                            productDetail: _newOrder.productDetail,
                            date: _newOrder.date,
                          );
                        },
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              // resizeToAvoidBottomInset: true,
              extendBody: true,

              // drawerScrimColor: Colors.white,
              persistentFooterAlignment: AlignmentDirectional.center,
              persistentFooterButtons: [
                CustomButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NewOrderProductPage(),
                      ),
                    );
                  },
                  text: 'Next',
                ),
              ],
            );
          } else {
            return const MyLogin();
          }
        });
  }
}

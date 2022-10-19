import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';
import 'package:nbt/screens/login_screen.dart';
import 'package:nbt/widgets/app_bar_functions.dart';
import 'package:intl/intl.dart';
import 'package:nbt/widgets/new_order_muti_form.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/new-orders';

  @override
  State<NewOrdersScreen> createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  final _form = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _poNumController = TextEditingController();

  var _newOrder = Transaction1(
    id: '',
    productName: '',
    partyName: '',
    factoryName: '',
    address: '',
    quantity: '',
    productDetail: '',
    price: '',
    transportation: '',
    date: DateTime.now(),
  );

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    // _dateController.text = DateTime.now() as String;
    // final args = ModalRoute.of(context)?.settings.arguments as String;
    // print('Arguments pass from list with length: $args');

    // var total = 100 + transaction.length;
    // _poNumController.text = total.toString();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // final args = ModalRoute.of(context)?.settings.arguments as String;

    // var total = 100 + int.parse(args);
    //
    // _poNumController.text = total.toString();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _poNumController.dispose();
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
    var transactionData = Provider.of<Transactions>(context);
    // final transaction = transactionData.poId;

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
              // appBar: appBarForNewOrder('CREATE NEW ORDER'),
              appBar: AppBar(
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
                      NewOrderMultiForm(, onRemove: () {}),

                      TextFormField(
                        decoration: const InputDecoration(label: Text('Date')),
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
                            price: _newOrder.price,
                            transportation: _newOrder.transportation,
                            date: DateTime.now(),
                          );
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('PO Number')),
                        textInputAction: TextInputAction.next,
                        // enabled: false,
                        controller: _poNumController,
                        // initialValue: transaction.toString(),
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: value!,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Name of Product')),
                        maxLines: 3,
                        // textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Product Name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: value!,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Party Name')),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus();
                        },
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
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Factory Name')),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus();
                        },
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
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      // TextFormField(
                      //   decoration: const InputDecoration(label: Text('Address')),
                      //   textInputAction: TextInputAction.next,
                      //   onFieldSubmitted: (_) {
                      //     FocusScope.of(context).requestFocus();
                      //   },
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter Product Name!';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Address')),
                        maxLines: 3,
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
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: value!,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Quantity (KG)')),
                        textInputAction: TextInputAction.next,
                        // onFieldSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus();
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Quantity!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: value!,
                              productDetail: _newOrder.productDetail,
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(label: Text('Price')),
                        textInputAction: TextInputAction.next,
                        // keyboardType: TextInputType.multiline,
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

                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              price: value!,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Transportation')),
                        // maxLines: 5,
                        textInputAction: TextInputAction.next,

                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: _newOrder.productDetail,
                              price: _newOrder.price,
                              transportation: value!,
                              date: _newOrder.date);
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Description')),
                        maxLines: 5,
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
                        onSaved: (value) {
                          _newOrder = Transaction1(
                              id: _newOrder.id,
                              productName: _newOrder.productName,
                              partyName: _newOrder.partyName,
                              factoryName: _newOrder.factoryName,
                              address: _newOrder.address,
                              quantity: _newOrder.quantity,
                              productDetail: value!,
                              price: _newOrder.price,
                              transportation: _newOrder.transportation,
                              date: _newOrder.date);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const MyLogin();
          }
        });
  }
}

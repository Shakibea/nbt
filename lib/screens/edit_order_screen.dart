import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';
import 'package:nbt/widgets/app_bar_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';
import '../widgets/new_order_page/custom_button.dart';

class EditOrdersScreen extends StatefulWidget {
  const EditOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-orders';

  @override
  State<EditOrdersScreen> createState() => _EditOrdersScreenState();
}

class _EditOrdersScreenState extends State<EditOrdersScreen> {
  var space = 15.0;
  final _form = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _poNumController = TextEditingController();
  final _poNameController = TextEditingController();
  final _partyNameController = TextEditingController();
  final _factoryNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _transportationController = TextEditingController();

  late String status;
  late String id;
  String? orderId;
  String? getColor;

  var _initLoad = false;

  var _newOrder = Transaction1(
    id: '',
    productName: '',
    partyName: '',
    factoryName: '',
    transportation: '',
    address: '',
    quantity: '',
    productDetail: '',
    date: DateTime.now(),
  );

  @override
  void initState() {
    // _dateController.text = DateFormat.yMMMMd().format(DateTime.now());

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

    // final orderId = ModalRoute.of(context)?.settings.arguments as String;
    // final docRef = FirebaseFirestore.instance.collection("orders").doc(orderId);
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //
    //
    //     _newOrder = Transaction1(
    //       id: data['id'],
    //       productName: data['productName'],
    //       partyName: data['partyName'],
    //       factoryName: data['factoryName'],
    //       address: data['address'],
    //       quantity: data['quantity'],
    //       productDetail: data['productDetail'],
    //       date: data['date'],
    //     );
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

    if (!_initLoad) {
      final orderId = ModalRoute.of(context)?.settings.arguments as String;
      // final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
      //     <String, String>{}) as Map;
      // orderId = routeArgs['id'];
      // getColor = routeArgs['getColor'];

      final docRef =
          FirebaseFirestore.instance.collection("orders").doc(orderId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // _dateController.text = DateFormat.yMMMMd().format(data['date']);
          id = data['id'];
          _poNumController.text = id;
          _dateController.text =
              DateFormat.yMMMMd().format((data['date'] as Timestamp).toDate());
          _poNameController.text = data['productName'];
          _partyNameController.text = data['partyName'];
          _factoryNameController.text = data['factoryName'];
          _addressController.text = data['address'];
          _quantityController.text = data['quantity'];

          _descriptionController.text = data['productDetail'];

          status = data['status'];
          _transportationController.text = data['transportation'];

          // print(
          //     'productName from firestore: ${(data['date'] as Timestamp).toDate()}');
        },
        onError: (e) => print("Error getting document: $e"),
      );

      _initLoad = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _poNumController.dispose();
    _poNameController.dispose();
    _partyNameController.dispose();
    _factoryNameController.dispose();
    _addressController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _transportationController.dispose();
    super.dispose();
  }

  void _saveForm() {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    // Provider.of<Transactions>(context, listen: false).addProduct(_newOrder);
    Provider.of<Transactions>(context, listen: false)
        .updateOrders(_newOrder, id, status);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context);
    // final transaction = transactionData.poId;
    var textFieldColor = const Color(0xff511C74);

    return Scaffold(
      // appBar: appBarForNewOrder('CREATE NEW ORDER'),
      appBar: AppBar(
        title: const Text('Edit Order Details'),
        backgroundColor: const Color(0xff511C74),
        // actions: [
        //   IconButton(
        //     onPressed: _saveForm,
        //     icon: const Icon(Icons.save),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: Text('Date'),
                  labelStyle: TextStyle(
                    color: textFieldColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _dateController,
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: _newOrder.factoryName,
                    transportation: _newOrder.transportation,
                    address: _newOrder.address,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: DateTime.now(),
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: Text('PO Number'),
                  labelStyle: TextStyle(
                    color: textFieldColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                enabled: false,
                controller: _poNumController,
                onSaved: (value) {
                  _newOrder = Transaction1(
                      id: value!,
                      productName: _newOrder.productName,
                      partyName: _newOrder.partyName,
                      factoryName: _newOrder.factoryName,
                      transportation: _newOrder.transportation,
                      address: _newOrder.address,
                      quantity: _newOrder.quantity,
                      productDetail: _newOrder.productDetail,
                      date: _newOrder.date);
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: Text('Party Name'),
                  labelStyle: TextStyle(
                    color: textFieldColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Party Name!';
                  }
                  return null;
                },
                controller: _partyNameController,
                onSaved: (value) {
                  _newOrder = Transaction1(
                      id: _newOrder.id,
                      productName: _newOrder.productName,
                      partyName: value!,
                      factoryName: _newOrder.factoryName,
                      transportation: _newOrder.transportation,
                      address: _newOrder.address,
                      quantity: _newOrder.quantity,
                      productDetail: _newOrder.productDetail,
                      date: _newOrder.date);
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: Text('Factory Name'),
                  labelStyle: TextStyle(
                    color: textFieldColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Factory Name!';
                  }
                  return null;
                },
                controller: _factoryNameController,
                onSaved: (value) {
                  _newOrder = Transaction1(
                      id: _newOrder.id,
                      productName: _newOrder.productName,
                      partyName: _newOrder.partyName,
                      factoryName: value!,
                      transportation: _newOrder.transportation,
                      address: _newOrder.address,
                      quantity: _newOrder.quantity,
                      productDetail: _newOrder.productDetail,
                      date: _newOrder.date);
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: Text('Address'),
                  labelStyle: TextStyle(
                    color: textFieldColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter address';
                  }
                  // if (value.length <= 10) {
                  //   return 'above 10';
                  // }
                  return null;
                },
                controller: _addressController,
                //
                onSaved: (value) {
                  _newOrder = Transaction1(
                    id: _newOrder.id,
                    productName: _newOrder.productName,
                    partyName: _newOrder.partyName,
                    factoryName: _newOrder.factoryName,
                    address: value!,
                    transportation: _newOrder.transportation,
                    quantity: _newOrder.quantity,
                    productDetail: _newOrder.productDetail,
                    date: _newOrder.date,
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: Text('Transportation'),
                  labelStyle: TextStyle(
                    color: textFieldColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textFieldColor,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter transportation name!';
                  }
                  return null;
                },
                controller: _transportationController,
                onSaved: (value) {
                  _newOrder = Transaction1(
                      id: _newOrder.id,
                      productName: _newOrder.productName,
                      partyName: _newOrder.partyName,
                      factoryName: _newOrder.factoryName,
                      transportation: value!,
                      address: _newOrder.address,
                      quantity: _newOrder.quantity,
                      productDetail: _newOrder.productDetail,
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

              // TextFormField(
              //   decoration: const InputDecoration(label: Text('Quantity')),
              //   textInputAction: TextInputAction.next,
              //   // onFieldSubmitted: (_) {
              //   //   FocusScope.of(context).requestFocus();
              //   // },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter Quantity!';
              //     }
              //     return null;
              //   },
              //   controller: _quantityController,
              //
              //   onSaved: (value) {
              //     _newOrder = Transaction1(
              //         id: _newOrder.id,
              //         productName: _newOrder.productName,
              //         partyName: _newOrder.partyName,
              //         factoryName: _newOrder.factoryName,
              //         address: _newOrder.address,
              //         quantity: value!,
              //         productDetail: _newOrder.productDetail,
              //         date: _newOrder.date);
              //   },
              // ),
              // TextFormField(
              //   decoration: const InputDecoration(label: Text('Description')),
              //   maxLines: 5,
              //   keyboardType: TextInputType.multiline,
              //   // focusNode: _descriptionFocusNode,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter anything';
              //     }
              //     // if (value.length <= 10) {
              //     //   return 'above 10';
              //     // }
              //     return null;
              //   },
              //   controller: _descriptionController,
              //
              //   onSaved: (value) {
              //     _newOrder = Transaction1(
              //         id: _newOrder.id,
              //         productName: _newOrder.productName,
              //         partyName: _newOrder.partyName,
              //         factoryName: _newOrder.factoryName,
              //         address: _newOrder.address,
              //         quantity: _newOrder.quantity,
              //         productDetail: value!,
              //         date: _newOrder.date);
              //   },
              // ),
            ],
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        CustomButton(
          text: 'Save',
          onTap: _saveForm,
        ),
      ],
    );
  }
}

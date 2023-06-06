import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';
import 'package:nbt/widgets/app_bar_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/return.dart';
import '../providers/returns.dart';
import '../providers/transactions.dart';
import '../widgets/new_order_page/custom_button.dart';

class EditReturnsScreen extends StatefulWidget {
  const EditReturnsScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-returns';

  @override
  State<EditReturnsScreen> createState() => _EditReturnsScreenState();
}

class _EditReturnsScreenState extends State<EditReturnsScreen> {
  var space = 15.0;
  final _form = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _idController = TextEditingController();
  final _productNameController = TextEditingController();
  final _partyNameController = TextEditingController();
  final _factoryNameController = TextEditingController();
  final _remarksController = TextEditingController();
  final _quantityController = TextEditingController();
  // final _descriptionController = TextEditingController();
  // final _transportationController = TextEditingController();

  late String status;
  late String uid;
  // String? orderId;
  // String? getColor;

  var _initLoad = false;

  var _newReturn = Return(
    id: '',
    productName: '',
    partyName: '',
    factoryName: '',
    remarks: '',
    quantity: '',
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
      final returnsUid = ModalRoute.of(context)?.settings.arguments as String;
      // final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
      //     <String, String>{}) as Map;
      // orderId = routeArgs['id'];
      // getColor = routeArgs['getColor'];

      final docRef =
          FirebaseFirestore.instance.collection("returns").doc(returnsUid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // _dateController.text = DateFormat.yMMMMd().format(data['date']);
          uid = data['uid'];
          _idController.text = data['id'];
          _dateController.text =
              DateFormat.yMMMMd().format((data['date'] as Timestamp).toDate());
          _productNameController.text = data['productName'];
          _partyNameController.text = data['partyName'];
          _factoryNameController.text = data['factoryName'];
          _quantityController.text = data['quantity'];

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
    _idController.dispose();
    _productNameController.dispose();
    _partyNameController.dispose();
    _factoryNameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _saveForm() {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    // Provider.of<Transactions>(context, listen: false).addProduct(_newOrder);
    Provider.of<Returns>(context, listen: false).updateReturns(_newReturn, uid);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context);
    // final transaction = transactionData.poId;
    var textFieldColor = const Color(0xff279758);

    return Scaffold(
      // appBar: appBarForNewOrder('CREATE NEW ORDER'),
      appBar: AppBar(
        title: const Text('Edit Returns Details'),
        backgroundColor: const Color(0xff279758),
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
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
                  label: const Text('Date'),
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
                  _newReturn = Return(
                    id: _newReturn.id,
                    productName: _newReturn.productName,
                    partyName: _newReturn.partyName,
                    factoryName: _newReturn.factoryName,
                    quantity: _newReturn.quantity,
                    remarks: _newReturn.remarks,
                    date: DateTime.now(),
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Returns Number'),
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
                    return 'Please enter Returns Number!';
                  }
                  return null;
                },
                controller: _idController,
                onSaved: (value) {
                  _newReturn = Return(
                    id: value!,
                    productName: _newReturn.productName,
                    partyName: _newReturn.partyName,
                    factoryName: _newReturn.factoryName,
                    quantity: _newReturn.quantity,
                    remarks: _newReturn.remarks,
                    date: _newReturn.date,
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Name of Product'),
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
                    return 'Please enter Product Name!';
                  }
                  return null;
                },
                controller: _productNameController,
                onSaved: (value) {
                  _newReturn = Return(
                    id: _newReturn.id,
                    productName: value!,
                    partyName: _newReturn.partyName,
                    factoryName: _newReturn.factoryName,
                    quantity: _newReturn.quantity,
                    remarks: _newReturn.remarks,
                    date: _newReturn.date,
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Party Name'),
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
                  _newReturn = Return(
                    id: _newReturn.id,
                    productName: _newReturn.productName,
                    partyName: value!,
                    factoryName: _newReturn.factoryName,
                    quantity: _newReturn.quantity,
                    remarks: _newReturn.remarks,
                    date: _newReturn.date,
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Factory Name'),
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
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter Factory Name!';
                //   }
                //   return null;
                // },
                controller: _factoryNameController,
                onSaved: (value) {
                  _newReturn = Return(
                    id: _newReturn.id,
                    productName: _newReturn.productName,
                    partyName: _newReturn.partyName,
                    factoryName: value!,
                    quantity: _newReturn.quantity,
                    remarks: _newReturn.remarks,
                    date: _newReturn.date,
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Requested Quantity'),
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
                    return 'Please enter Quantity';
                  }
                  // if (value.length <= 10) {
                  //   return 'above 10';
                  // }
                  return null;
                },
                controller: _quantityController,
                //
                onSaved: (value) {
                  _newReturn = Return(
                    id: _newReturn.id,
                    productName: _newReturn.productName,
                    partyName: _newReturn.partyName,
                    factoryName: _newReturn.factoryName,
                    quantity: value!,
                    remarks: _newReturn.remarks,
                    date: _newReturn.date,
                  );
                },
              ),
              SizedBox(height: space),
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Remarks'),
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
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter transportation name!';
                //   }
                //   return null;
                // },
                controller: _remarksController,
                onSaved: (value) {
                  _newReturn = Return(
                    id: _newReturn.id,
                    productName: _newReturn.productName,
                    partyName: _newReturn.partyName,
                    factoryName: _newReturn.factoryName,
                    quantity: _newReturn.quantity,
                    remarks: value!,
                    date: _newReturn.date,
                  );
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
      // persistentFooterAlignment: AlignmentDirectional.center,
      // persistentFooterButtons: [
      //   CustomButton(
      //     text: 'Save',
      //     onTap: _saveForm,
      //   ),
      // ],
    );
  }
}

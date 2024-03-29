import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nbt/providers/product.dart';
import 'package:nbt/providers/transaction.dart';
import 'package:nbt/screens/order_details_screen.dart';
import 'package:nbt/widgets/app_bar_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/transactions.dart';
import '../widgets/new_order_page/custom_button.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final String orderId;
  const EditProductScreen(
      {Key? key, required this.productId, required this.orderId})
      : super(key: key);

  // static const routeName = '/edit-orders';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var space = 15.0;
  final _form = GlobalKey<FormState>();
  // final _dateController = TextEditingController();
  // final _poNumController = TextEditingController();
  final _poNameController = TextEditingController();
  // final _partyNameController = TextEditingController();
  // final _factoryNameController = TextEditingController();
  // final _addressController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  late String status;
  late String id;
  String? orderId;
  String? getColor;

  var _initLoad = false;

  var _newProduct = Product(
    id: '',
    name: '',
    quantity: '',
    price: 0,
    description: '',
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
      // final orderId = ModalRoute.of(context)?.settings.arguments as String;
      // final routeArgs = (ModalRoute.of(context)?.settings.arguments ??
      //     <String, String>{}) as Map;
      // orderId = routeArgs['id'];
      // getColor = routeArgs['getColor'];

      final docRef = FirebaseFirestore.instance
          .collection("orders")
          .doc(widget.orderId)
          .collection('products')
          .doc(widget.productId);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // _dateController.text = DateFormat.yMMMMd().format(data['date']);
          print(data['name'].toString());
          print(data['price'].toString());
          id = data['id'].toString();
          // _poNumController.text = id;
          // _dateController.text =
          //     DateFormat.yMMMMd().format((data['date'] as Timestamp).toDate());
          _poNameController.text = data['name'].toString();
          // _partyNameController.text = data['partyName'];
          // _factoryNameController.text = data['factoryName'];
          // _addressController.text = data['address'];
          _quantityController.text = data['quantity'].toString();
          _descriptionController.text = data['description'].toString();
          _priceController.text = data['price'].toString();

          // status = data['status'];

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
    // _dateController.dispose();
    // _poNumController.dispose();
    _poNameController.dispose();
    // _partyNameController.dispose();
    // _factoryNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    var valid = _form.currentState?.validate();
    if (!valid!) {
      return; // not valid
    }
    _form.currentState?.save();

    // Provider.of<Transactions>(context, listen: false).addProduct(_newOrder);
    Provider.of<Products>(context, listen: false).updateProducts(
      _newProduct,
      widget.orderId,
      widget.productId,
    );

    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (_) => OrderDetailsScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    var transactionData = Provider.of<Transactions>(context);
    // final transaction = transactionData.poId;
    var textFieldColor = const Color(0xff511C74);

    return Scaffold(
      // appBar: appBarForNewOrder('CREATE NEW ORDER'),
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: const Color(0xff511C74),
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              // Name
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
                controller: _poNameController,
                onSaved: (value) {
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: value!,
                    quantity: _newProduct.quantity,
                    price: _newProduct.price,
                    description: _newProduct.description,
                  );
                },
              ),
              SizedBox(height: space),
              // Quantity
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Quantity (KG)'),
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
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus();
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Quantity!';
                  }
                  return null;
                },
                controller: _quantityController,

                onSaved: (value) {
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: _newProduct.name,
                    quantity: value!,
                    price: _newProduct.price,
                    description: _newProduct.description,
                  );
                },
              ),
              SizedBox(height: space),
              // Price
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Price'),
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
                    return 'Please enter Price!';
                  }
                  return null;
                },
                controller: _priceController,
                onSaved: (value) {
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: _newProduct.name,
                    quantity: _newProduct.quantity,
                    price: double.parse(value!),
                    description: _newProduct.description,
                  );
                },
              ),
              SizedBox(height: space),
              // Description
              TextFormField(
                cursorColor: textFieldColor,
                decoration: InputDecoration(
                  label: const Text('Description'),
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
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter anything';
                //   }
                //   // if (value.length <= 10) {
                //   //   return 'above 10';
                //   // }
                //   return null;
                // },
                controller: _descriptionController,

                onSaved: (value) {
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: _newProduct.name,
                    quantity: _newProduct.quantity,
                    price: _newProduct.price,
                    description: value!,
                  );
                },
              ),
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

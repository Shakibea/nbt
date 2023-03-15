// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nbt/providers/NewOrderProvider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/product.dart';
import '../providers/transaction.dart';
import '../providers/transactions.dart';
import './login_screen.dart';
import '../widgets/new_order_page/custom_text_field.dart';
import '../widgets/new_order_page/custom_button.dart';

class NewOrderProductPage extends StatefulWidget {
  const NewOrderProductPage({Key? key}) : super(key: key);

  @override
  State<NewOrderProductPage> createState() => _NewOrderProductPageState();
}

class _NewOrderProductPageState extends State<NewOrderProductPage> {
  // var _increase = 1;
  final _form = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
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

  List<ProductForm> _forms = [
    ProductForm(),
  ];

  void removeProduct(int i) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ADD NEW PRODUCT'),
        backgroundColor: const Color(0xff511C74),
        actions: [
          IconButton(
            onPressed: () {
              // setState(() {
              //   if (_increase == 10) {
              //     _increase;
              //   } else {
              //     _increase++;
              //   }
              // });
              // Provider.of<NewOrderProvider>(context, listen: false)
              //     .incrementCount();
              _forms.add(
                ProductForm(
                  onPressed: () {
                    // _forms.removeAt(1);
                  },
                  product: Product(),
                ),
              );
              print(_forms);
              setState(() {});
            },
            icon: const Icon(Icons.add_circle_outline),
          )
        ],
      ),
      body: ListView.builder(
        // itemCount: _increase,
        // itemCount: Provider.of<NewOrderProvider>(context).count,
        itemCount: _forms.length,
        itemBuilder: (context, i) {
          final products = _forms[i];
          return ListTile(
            key: Key(i.toString()),
            subtitle: TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(135, 20),
              ),
              onPressed: () {
                setState(() {
                  // _forms.removeAt(products);
                  print(i);
                });
              },
              child: Text('Delete'),
            ),
            title: _forms[i],
          );

          // Column(
          // children: [
          //   _forms[i],
          //   TextButton(
          //     onPressed: () {
          //       setState(() {
          //         _forms.removeAt(i);
          //         print(i);
          //       });
          //     },
          //     child: Text('Delete'),
          //   ),
          // ],
          // );
        },
      ),
      // resizeToAvoidBottomInset: true,
      // extendBody: true,

      // drawerScrimColor: Colors.white,
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        CustomButton(text: 'Submit'),
      ],
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

  var _newOrder = Product(
    id: '',
    name: '',
    quantity: '',
    price: '',
    description: '',
  );

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
                onSaved: (value) {
                  _newOrder = Product(
                    id: _newOrder.id,
                    name: value!,
                    quantity: _newOrder.quantity,
                    price: _newOrder.price,
                    description: _newOrder.description,
                  );
                },
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
                onSaved: (value) {
                  _newOrder = Product(
                    id: _newOrder.id,
                    name: _newOrder.name,
                    quantity: value!,
                    price: _newOrder.price,
                    description: _newOrder.description,
                  );
                },
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
                onSaved: (value) {
                  _newOrder = Product(
                    id: _newOrder.id,
                    name: _newOrder.name,
                    quantity: _newOrder.quantity,
                    price: value!,
                    description: _newOrder.description,
                  );
                },
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
                onSaved: (value) {
                  _newOrder = Product(
                    id: _newOrder.id,
                    name: _newOrder.name,
                    quantity: _newOrder.quantity,
                    price: _newOrder.price,
                    description: value!,
                  );
                },
              ),
              SizedBox(height: 15),
              ListTile(
                trailing: TextButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

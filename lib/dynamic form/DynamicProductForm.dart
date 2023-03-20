// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nbt/providers/transaction.dart';
import 'package:provider/provider.dart';

import '../providers/transactions.dart';
import '../widgets/new_order_page/custom_text_field.dart';
import '../providers/product.dart';

class DynamicProductForm extends StatefulWidget {
  // final String id;
  final Transaction1 transaction1;

  const DynamicProductForm({Key? key, required this.transaction1})
      : super(key: key);

  @override
  _DynamicProductFormState createState() => _DynamicProductFormState();
}

class _DynamicProductFormState extends State<DynamicProductForm> {
  List<Product> _products = [];

  final _formKey = GlobalKey<FormState>();
  // final orderId = ModalRoute.of(context)!.settings.arguments;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // var _newProduct = Product(
  //   id: '',
  //   name: '',
  //   quantity: '',
  //   price: 0,
  //   description: '',
  // );

  late Product _newProduct;

  @override
  void initState() {
    _newProduct = Product(
      id: '',
      name: '',
      quantity: '',
      price: 0,
      description: '',
    );

    super.initState();
  }

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: '',
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _detailsController.text,
        quantity: _quantityController.text,
      );
      setState(() {
        _products.add(product);
        _nameController.clear();
        _priceController.clear();
        _detailsController.clear();
        _quantityController.clear();
      });
      // _formKey.currentState?.save();

      // order
      // Provider.of<Transactions>(context, listen: false).createOrder(
      //   widget.transaction1,
      // );

      // product
      // Provider.of<Transactions>(context, listen: false).createProduct(
      //   product,
      //   widget.transaction1.id,
      // );
    }
  }

  void _saveForm() {
    // var valid = _formKey.currentState?.validate();
    // if (!valid!) {
    //   return; // not valid
    // }

    print(_products);

    _formKey.currentState?.save();

    // order
    Provider.of<Transactions>(context, listen: false).createOrder(
      widget.transaction1,
    );

    // product
    Provider.of<Transactions>(context, listen: false).createProduct(
      _newProduct,
      widget.transaction1.id,
    );
    // Navigator.of(context).pop();
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => DynamicProductForm(
    //       transaction1: _newOrder,
    //     ),
    //   ),
    // );
  }

  void _removeProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD NEW PRODUCT'),
        backgroundColor: const Color(0xff511C74),
        actions: [
          TextButton(
            onPressed: _saveForm,
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // IconButton(
          //   onPressed: _saveForm,
          //   icon: const Icon(Icons.save),
          // )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Name of Product',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enabled: true,
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Name!';
                  }
                  return null;
                },
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
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: _newProduct.name,
                    quantity: value!,
                    price: _newProduct.price,
                    description: _newProduct.description,
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
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: _newProduct.name,
                    quantity: _newProduct.quantity,
                    price: double.parse(value!),
                    description: _newProduct.description,
                  );
                },
              ),
              SizedBox(height: 15),
              // Description
              CustomTextField(
                labelText: 'Description',
                textInputAction: TextInputAction.done,
                enabled: true,
                controller: _detailsController,
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
                  _newProduct = Product(
                    id: _newProduct.id,
                    name: _newProduct.name,
                    quantity: _newProduct.quantity,
                    price: _newProduct.price,
                    description: value!,
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff511C74),
                ),
                child: Text('Add Product'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = _products[index];
                    return ListTile(
                      title: Text(product.name.toString()),
                      subtitle: Text(
                          '\$${product.price.toStringAsFixed(2)} - Qty: ${product.quantity} - ${product.description}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        // _removeProduct(index);
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
                                  _removeProduct(index);
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

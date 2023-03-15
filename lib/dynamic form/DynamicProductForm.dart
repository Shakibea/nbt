import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  String details;
  int quantity;

  Product(
      {required this.name,
      required this.price,
      required this.details,
      required this.quantity});
}

class DynamicProductForm extends StatefulWidget {
  const DynamicProductForm({Key? key}) : super(key: key);

  @override
  _DynamicProductFormState createState() => _DynamicProductFormState();
}

class _DynamicProductFormState extends State<DynamicProductForm> {
  List<Product> _products = [];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final product = Product(
          name: _nameController.text,
          price: double.parse(_priceController.text),
          details: _detailsController.text,
          quantity: int.parse(_quantityController.text),
        );
        _products.add(product);
        _nameController.clear();
        _priceController.clear();
        _detailsController.clear();
        _quantityController.clear();
      });
    }
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
        title: Text('Dynamic Form'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: 'Details',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter details';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid quantity';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = _products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        '\$${product.price.toStringAsFixed(2)} - ${product.details} - Qty: ${product.quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeProduct(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

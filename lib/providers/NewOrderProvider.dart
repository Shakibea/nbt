// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './product.dart';

class NewOrderProvider extends ChangeNotifier {
  int _count = 1;
  int get count => _count;

  List<Product> _products = [
    Product(
      id: "01",
      name: 'ads',
      quantity: "15",
      price: '5',
      description: 'sdhdha',
    ),
  ];

  List<Product> get products => [..._products];

  void addProduct(Product product) {
    try {
      final newProduct = Product(
        id: product.id,
        name: product.name,
        quantity: product.quantity,
        price: product.price,
        description: product.description,
      );
      _products.add(newProduct);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  void deleteProduct(int id) {
    // final existingProductIndex =
    //     _products.indexWhere((element) => element.id == id);

    // print('Existing $existingProductIndex');
    print('id $id');

    _products.removeAt(id);
    notifyListeners();
  }

  void incrementCount() {
    if (_count == 10) {
      _count;
    } else {
      _count++;
      // addProduct();
      print(_products);
    }
    notifyListeners();
  }

  void decrementCount(int index) {
    if (_count == 1) {
      _count;
    } else {
      // _count--;
      deleteProduct(index);
      Fluttertoast.showToast(
        msg: "Product removed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
    notifyListeners();
  }

}

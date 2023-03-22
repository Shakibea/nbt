import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import './product.dart';

class Products with ChangeNotifier {
  Future<void> createProduct(List<Product> products, String id) async {
    // random id generated
    // String productId = const Uuid().v1();
    final docProduct = FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .collection('products');

    // print(docProduct.id);

    for (final product in products) {
      final documentRef = await docProduct.add(product.toFirestore());
      print('Added product with ID: ${documentRef.id}');
    }

    // final json = newProduct.toFirestore();
    // await docProduct.add(json);
    notifyListeners();
  }
}

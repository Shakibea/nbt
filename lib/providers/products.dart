import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import './product.dart';

class Products with ChangeNotifier {
  Future createProduct(Product product, String id) async {
    String productId = const Uuid().v1();
    final docProduct = FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .collection('products')
        .doc(productId);

    // print(docProduct.id);

    final newProduct = Product(
      id: docProduct.id,
      name: product.name,
      quantity: product.quantity,
      price: product.price,
      description: product.description,
    );

    final json = newProduct.toJson();
    await docProduct.set(json);
  }
}

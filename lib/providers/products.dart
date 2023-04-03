import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import './product.dart';

class Products with ChangeNotifier {
  Future<void> createProduct(List<Product> products, String id) async {
    final docProduct = FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .collection('products');

    // print(docProduct.id);

    for (final product in products) {
      // random id generated
      String productId = Uuid().v1();
      // final documentRef =
      await docProduct.doc(productId).set(product.toFirestore(productId));
      // print('Added product with ID: ${documentRef.id}');
      print('Added product with ID: ${productId}');
    }

    // final json = newProduct.toFirestore();
    // await docProduct.add(json);
    notifyListeners();
  }

  Future<void> updateProducts(
      Product product, String orderId, String productId) async {
    final docOrder = FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .collection('products')
        .doc(productId);
    final updateOrder = Product(
      id: docOrder.id,
      name: product.name,
      quantity: product.quantity,
      price: product.price,
      description: product.description,
    );

    final json = updateOrder.toJson();
    await docOrder.update(json);

    notifyListeners();

    // await docOrder.update(updateOrder as Map<String, dynamic>);
  }

  Future deleteProduct(String id, String productId) async {
    final docProduct = FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .collection('products')
        .doc(productId);
    await docProduct.delete();
  }
}

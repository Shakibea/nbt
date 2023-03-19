import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nbt/providers/product.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addProduct(
    String productId,
    String productName,
    String productQuantity,
    String productPrice,
    String productDescription,
    String orderId,
  ) async {
    String res = "Some error occurred";
    try {
      if (productName.isNotEmpty) {
        String productId = const Uuid().v1();
        Product product = Product(
          id: productId,
          name: productName,
          quantity: productQuantity,
          price: productPrice,
          description: productDescription,
        );
        await _firestore
            .collection('orders')
            .doc(orderId)
            .collection('products')
            .doc(productId)
            .set(product.toJson());

        res = "Success";
      } else {
        res = 'Text is empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> deleteProduct(String orderId, String productId) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .collection('products')
          .doc(productId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

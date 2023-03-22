import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String quantity;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'description': description,
      };

  // factory Product.fromJson(Map<String, dynamic> json) => Product(
  //       id: json['id'],
  //       name: json['name'],
  //       quantity: json['quantity'],
  //       price: json['price'],
  //       description: json['description'],
  //     );
  //
  // static Product fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //
  //   return Product(
  //     id: snapshot['id'],
  //     name: snapshot['name'],
  //     quantity: snapshot['quantity'],
  //     price: snapshot['price'],
  //     description: snapshot['description'],
  //   );
  // }

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      name: data?['name'],
      price: data?['price'],
      description: data?['description'],
      quantity: data?['quantity'],
      id: data?['id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (description != null) "description": description,
      if (quantity != null) "quantity": quantity
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String? name;
  final String? quantity;
  final double price;
  final String? description;

  Product({
    this.id,
    this.name,
    this.quantity,
    required this.price,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'description': description,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        quantity: json['quantity'],
        price: json['price'],
        description: json['description'],
      );

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Product(
      id: snapshot['id'],
      name: snapshot['name'],
      quantity: snapshot['quantity'],
      price: snapshot['price'],
      description: snapshot['description'],
    );
  }
}

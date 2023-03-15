// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';
//
// class FirestoreMethod {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<String> addProduct(
//       String
//     String productId,
//     String productName,
//     String productQuantity,
//     String productPrice,
//     String productDescription,
//   ) async {
//     String res = "Some error occurred";
//     try {
//       if (productName.isNotEmpty) {
//         String productId = const Uuid().v1();
//         await _firestore
//             .collection('orders')
//             .doc(orderId)
//             .collection('products')
//             .doc(productId)
//             .set({
//           'userId': userId,
//           'userName': userName,
//           'userProfileImage': userProfileImage,
//           'postId': postId,
//           'cmntId': cmntId,
//           'cmntText': cmntText,
//           'cmntDatePublished': DateTime.now(),
//           'cmntLikes': [],
//         });
//
//         res = "Success";
//       } else {
//         res = 'Text is empty';
//       }
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }
//
//
//
// }

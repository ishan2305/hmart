import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('product');

  Future updateUserData(
      String userid, String name, String email, bool isBrand) async {
    print("entered");

    return await userCollection.doc(uid).set({
      'uid': userid,
      'name': name,
      'email': email,
      'isBrand': isBrand,
    });
  }

  Future updateProductData(
      String productName, String description, int likes) async {
    print("entered");

    return await productCollection.doc().set({
      'productName': productName,
      'description': description,
      'brandId': uid,
      'likes': likes,
    });
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hmart/models/cart.dart';
import 'package:hmart/models/cart_item.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('product');

  Future updateUserData(String userid, String name, String email, bool isBrand,
      String cartJson) async {
    print("entered");
    // List<CartItem> cartList = [];
    // CartItem cartItem1 = CartItem(productID: "abcd");
    // CartItem cartItem2 = CartItem(productID: "abcd1");
    // CartItem cartItem3 = CartItem(productID: "abcd2");
    // cartList.add(cartItem1);
    // cartList.add(cartItem2);
    // cartList.add(cartItem3);
    // Cart cart = Cart(cart: cartList);
    // String cartJson = jsonEncode(cart);
    return await userCollection.doc(uid).set({
      'uid': userid,
      'name': name,
      'email': email,
      'isBrand': isBrand,
      'cart': cartJson,
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

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmart/models/cart_item.dart';
import 'package:hmart/services/google_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hmart/models/cart.dart';
import 'package:hmart/services/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<CartItem> cart = [];
final _auth = FirebaseAuth.instance;
dynamic user;

class _HomeScreenState extends State<HomeScreen> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.favorite,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                signOutGoogle();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Column(
        children: [
          TextFormField(onChanged: (val) {
            setState(() => search = val);
          }),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('product').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((document) {
                      if (!document['productName'].contains(search)) {
                        return Container(
                          height: 10.0,
                          child: Text(''),
                        );
                      } else
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(document['productName']),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  document['description'],
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.favorite),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.shopping_cart),
                                      onPressed: () async {
                                        print(document['productName']);
                                        CartItem cartItem = CartItem(
                                            productID: document['productName']);
                                        cart.add(cartItem);
                                        Cart cartList = Cart(cart: cart);
                                        String cartListJson =
                                            jsonEncode(cartList);
                                        user = _auth.currentUser;
                                        print("Database");
                                        print(cartListJson);
                                        await DatabaseService(uid: user.uid)
                                            .updateUserData(
                                                user.uid,
                                                user.displayName,
                                                user.email,
                                                false,
                                                cartListJson);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

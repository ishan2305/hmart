import 'package:flutter/material.dart';
import 'package:hmart/services/google_auth.dart';
import 'package:hmart/shared/constants.dart';
import 'package:hmart/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeBrand extends StatefulWidget {
  @override
  _HomeBrandState createState() => _HomeBrandState();
}

final _auth = FirebaseAuth.instance;
dynamic user;

class _HomeBrandState extends State<HomeBrand> {
  final _formkey = GlobalKey<FormState>();

  String productName = '';
  String description = '';
  String message = '';

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
                Icons.exit_to_app,
              ),
              onPressed: () {
                signOutGoogle();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Product Name'),
                  validator: (val) =>
                      val.isEmpty ? 'Enter a Product name' : null,
                  onChanged: (val) {
                    setState(() => productName = val);
                  }),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'description'),
                  validator: (val) => val.length < 6
                      ? 'Enter a description 6+ chars long'
                      : null,
                  onChanged: (val) {
                    setState(() => description = val);
                  }),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                child: Text('Add product'),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    user = _auth.currentUser;
                    await DatabaseService(uid: user.uid)
                        .updateProductData(productName, description, 0);
                  }
                  setState(() {
                    message = 'product updated';
                  });
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

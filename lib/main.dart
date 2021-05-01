import 'package:flutter/material.dart';
import 'package:hmart/screens/home.dart';
import 'package:hmart/screens/homebrand.dart';
import 'package:hmart/services/google_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hmart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In with google'),
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                signInWithGoogle(true).then((result) {
                  if (result != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeBrand()),
                    );
                  }
                });
              },
              child: Text('Sign In with google as a Brand'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                signInWithGoogle(false).then((result) {
                  if (result != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                });
              },
              child: Text('Sign In with google'),
            ),
          ),
        ],
      ),
    );
  }
}

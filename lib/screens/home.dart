import 'package:flutter/material.dart';
import 'package:hmart/services/google_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Center(
        child: Text(
          'User Signed In',
        ),
      ),
    );
  }
}

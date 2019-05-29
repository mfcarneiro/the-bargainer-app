import 'package:flutter/material.dart';
import './products.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductsPage()));
          },
        ),
      ),
    );
  }
}

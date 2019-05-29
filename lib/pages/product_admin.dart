import 'package:flutter/material.dart';
import './products.dart';

class ProductAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          AppBar(
            //! Remove the hamburger menu of the Toolbar
            automaticallyImplyLeading: false,
            title: Text('The Bargainer'),
          ),
          ListTile(
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductsPage()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text('The Bargainer'),
      ),
      body: Center(
        child: Text('Manage your products'),
      ),
    );
  }
}

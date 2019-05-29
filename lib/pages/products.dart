import 'package:flutter/material.dart';
import 'package:bargainer_app/product_manager.dart';
import '../pages/product_admin.dart';

class ProductsPage extends StatelessWidget {
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
                      builder: (BuildContext context) => ProductAdmin()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text('The Bargainer'),
      ),
      //! --> Using `Positional arguments`
      //! --> The same name passed by signature argument, need to be passed when it's called
      //! E.g `ProductManager(startingProduct: 'Sweet Potato')`
      body: ProductManager(),
    );
  }
}

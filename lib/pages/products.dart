import 'package:flutter/material.dart';

// Widgets
import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage({this.products});

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
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
            //* This is the more verbal way
            //* It's not wrong, but using named routes, will be used less code and be more readable
            //* Using the same name as configured on routes: parameter on main.dart file
            Navigator.pushReplacementNamed(context, '/admin');
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => ProductAdminPage()));
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('The Bargainer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      //! --> Using `Positional arguments`
      //! --> The same name passed by signature argument, need to be passed when it's called
      //! E.g `ProductManager(startingProduct: 'Sweet Potato')`
      body: Products(products: products),
    );
  }
}

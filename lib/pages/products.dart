import 'package:flutter/material.dart';
import 'package:bargainer_app/product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductsPage(this.products, this.addProduct, this.deleteProduct);

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
              //* This is the more verbal way
              //* It's not wrong, but using named routes, will be used less code and be more readable
              //* Using the same name as configurated on routes: parameter on main.dart file
              Navigator.pushReplacementNamed(context, '/admin');
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => ProductAdminPage()));
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
      body: ProductManager(products, addProduct, deleteProduct),
    );
  }
}

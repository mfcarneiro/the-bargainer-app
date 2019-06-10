import 'package:flutter/material.dart';
import './product_create.dart';
import './product_list.dart';

class ProductAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductAdminPage({this.addProduct, this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  Navigator.pushReplacementNamed(context, '/home');
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => ProductsPage()));
                },
              )
            ],
          )),
          appBar: AppBar(
            title: Text('The Bargainer'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.create), text: 'Create Product'),
                Tab(icon: Icon(Icons.list), text: 'Products')
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(addProduct: addProduct),
              ProductListPage()
            ],
          )),
    );
  }
}

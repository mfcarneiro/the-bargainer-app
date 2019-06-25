import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';

class ProductAdminPage extends StatelessWidget {
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
            Navigator.pushReplacementNamed(context, '/home');
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => ProductsPage()));
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('The Bargainer'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.create), text: 'Create Product'),
                Tab(icon: Icon(Icons.list), text: 'Products')
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[ProductEditPage(), ProductListPage()],
          )),
    );
  }
}

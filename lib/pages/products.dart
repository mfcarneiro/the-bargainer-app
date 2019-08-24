import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/scoped_main.dart';

import '../widgets/products/products.dart';
import '../widgets/basic_widgets/logout_list_tile.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage({@required this.model});

  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

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
          leading: Icon(Icons.mode_edit),
          title: Text('Manage Products'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/admin');
          },
        ),
        Divider(),
        LogoutListTile()
      ],
    ));
  }

  Widget _buildProductList() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget mainContent = Center(child: Text('No Products Found!'));

      if (model.getDisplayedProducts.length > 0 && !model.getLoadingProcess) {
        mainContent = Products();
      } else if (model.getLoadingProcess) {
        mainContent = Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
          //! Refresh Indicator create the "Pull to refresh" feature
          //! Since this Widget have their own spinner,  `onRefresh` method needs to receive a Future method
          onRefresh: model.fetchProducts,
          child: mainContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('The Bargainer'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(model.displayFavoritesOnly
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                model.toggleDisplayMode();
              },
            );
          }),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildProductList(),
    );
  }
}

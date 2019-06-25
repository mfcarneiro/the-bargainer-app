//! For every file added on Flutter
//! It will be needed to import the used libraries
//! This behavior exists because every file on Flutter works standalone
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../scoped_models/scoped_main.dart';
import '../products/product_card.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productCards;

    if (products.length > 0) {
      productCards = ListView.builder(
          padding: EdgeInsets.only(bottom: 10.0),
          itemBuilder: (BuildContext context, index) => ProductCard(
                product: products[index],
                productIndex: index,
              ),
          itemCount: products.length);
    } else {
      productCards = Center(
        child: Text('No Products were found'),
      );
    }

    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    // -> Whenever the data changes here, this method will be updated
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductList(model.getDisplayedProducts);
    });
  }
}

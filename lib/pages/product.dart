import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async'; //! Need to import to be able to use Future method

// Widgets
import '../widgets/products/price_chip.dart';
import '../widgets/basic_widgets/defaul_title.dart';

// Models
import '../models/product.dart';

// Scoped Models
import '../scoped_models/scoped_main.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

  @override
  Widget build(BuildContext context) {
    //! WillPopScope will wrap the widget to handle the back button of android and Toolbar
    //! When implemented this feature, will block by default the navigation
    return WillPopScope(onWillPop: () {
      Navigator.pop(context, false);

      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final Product products = model.allProducts[productIndex];

      return Scaffold(
          appBar: AppBar(
            title: Text('Product details'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Image.asset(
                  products.image,
                  repeat: ImageRepeat.noRepeat,
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: DefaultTitle(title: products.title)),
                                PriceChip(price: products.price),
                              ],
                            ),
                            Text(
                              products.description,
                              maxLines: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    }));
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// Widgets
import '../basic_widgets/defaul_title.dart';
import './address_chip.dart';
import './price_chip.dart';

// Model
import '../../models/product.dart';

// Scoped model
import '../../scoped_models/scoped_main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard({this.product, this.productIndex});

  Widget _buildPriceTextRow(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, left: 10.0),
        child: Row(children: <Widget>[
          DefaultTitle(title: product.title),
          PriceChip(price: product.price)
        ]));
  }

  Widget _buildCardActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(children: <Widget>[
        IconButton(
            icon: Icon(Icons.info_outline),
            splashColor: Colors.deepOrange,
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + productIndex.toString())),
        IconButton(
            color: Colors.red,
            icon: Icon(model.allProducts[productIndex].isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              model.setSelectedProductIndex(productIndex);
              model.toggleFavoriteProductStatus();
            })
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(15.0),
        child: Column(
            //* --> <Widget> It's a generic type on dart (In this case, A generic array type)
            children: <Widget>[
              //* --> On Dart, When use a dot notation, it means an constructor, accessing the wanted feature
              Image.asset(
                product.image,
              ),
              _buildPriceTextRow(context),
              AddressChip(label: 'Blumenau - SC'),
              SizedBox(
                height: 10.0,
              ),
              _buildCardActionButtons(context)
            ]));
  }
}

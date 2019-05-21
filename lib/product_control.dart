import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      child: Text('Add Product'),
      onPressed: () {
        //* `setState()` will watch for any changes and update the widget
        addProduct('Sweets');
      },
    );
  }
}

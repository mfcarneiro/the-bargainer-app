//! For every file added on Flutter
//! It will be needed to import the used libraries
//! This behavior exists because every file on Flutter works standalone
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  //* The `final` keyword it is the same convention to not mutate the data
  final List<String> productsItem;

  //* Set up the constructor to propagate the data comming from outside
  Products(this.productsItem);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: productsItem
            .map((element) => Card(
                  child: Column(
                    //* --> <Widget> It's a generic type on dart (In this case, A generic array type)
                    children: <Widget>[
                      //* --> On Dart, When use a dot notation, it means an constuctor, accessing the wanted feature
                      Image.asset(
                        'assets/food.jpg',
                      ),
                      Text(element)
                    ],
                  ),
                ))
            .toList());
  }
}

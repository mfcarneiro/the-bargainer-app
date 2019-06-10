import 'package:flutter/material.dart';
import 'products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductManager({this.products});

  @override
  //! When this `build` method run the first time
  //! The initState will be fired
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Products(products: products))
      // Container(
      //     //* EdgeInserts gives a margin to all the directions with a px value within
      //     margin: EdgeInsets.all(8),
      //     child: ProductControl(addProduct)),
    ]);
  }
}

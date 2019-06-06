import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  @override
  //! When this `build` method run the first time
  //! The initState will be fired
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          //* EdgeInserts gives a margin to all the directions with a px value within
          margin: EdgeInsets.all(8),
          child: ProductControl(addProduct)),
      Expanded(child: Products(products, deleteProduct: deleteProduct))
    ]);
  }
}

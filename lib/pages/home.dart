import 'package:flutter/material.dart';
import '../product_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Bargainer'),
      ),
      //! --> Using `Positional arguments`
      //! --> The same name passed by signature argument, need to be passed when it's called
      //! E.g `ProductManager(startingProduct: 'Sweet Potato')`
      body: ProductManager(),
    );
  }
}

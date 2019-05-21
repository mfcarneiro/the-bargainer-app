import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  //! We can receive external data on `StatefulWidged` too
  final String startingProduct;

  //* In Dart, we can specify the name witch argument will receives the data
  //! --> It's used around with {}  (This is called positional arguments)
  //* E.g: `ProductManager({this.startingProduct}`)
  ProductManager(this.startingProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  //! --> The `State` class has a method called `widget`
  //! --> This widget property is used because this method (productManagerState) is binded to the `State` class
  //! --> initState() will be fired when `ProductManager` was drawned on the screen (in the first time, for example)
  //! --> Then can be used the `widget.startingProduct`
  void initState() {
    super.initState(); //! --> always in top
    //! The flow explication
    //! `widget` is provided by `State` class
    //! the `State` class is connected to `ProductManager`
    //! Then give access to all the features (methods and variables) inside of `ProductManager` class
    _products.add(widget.startingProduct);
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  //! When this `build` method run the first time
  //! The initState will be fired
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          //* EdgeInserts gives a margin to all the directions with a px value within
          margin: EdgeInsets.all(8),
          child: ProductControl(_addProduct)),
      Products(_products)
    ]);
  }
}

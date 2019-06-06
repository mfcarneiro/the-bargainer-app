import 'package:flutter/material.dart';
import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  //! We can receive external data on `StatefulWidged` too
  final Map<String, String> startingProduct;

  //* In Dart, we can specify the name witch argument will receives the data
  //! --> It's used around with {}  (This is called positional arguments)
  //* E.g: `ProductManager({this.startingProduct}`)
  ProductManager({this.startingProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

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
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
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
      Expanded(child: Products(_products, deleteProduct: _deleteProduct))
    ]);
  }
}

//* List and Conditional notes
//! Whenever use a ListView widget, we must wrapper the giving constructor, a wrapper widget, that is required by ListView
//! Can be done with two wrapper widgets:
//! Container: Receives a height, required by ListView, that will control the size that will be displayed
//! Expanded: This will be fit all the screen size
//? Rendering a normal list, will hold all the items into memory, causing problems
//! A better way is using the constructor called ListView.builder()

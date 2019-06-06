//! For every file added on Flutter
//! It will be needed to import the used libraries
//! This behavior exists because every file on Flutter works standalone
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  //* The `final` keyword it is the same convention to not mutate the data
  final List<Map<String, String>> products;
  final Function deleteProduct;

  //* Set up the constructor to propagate the data comming from outside
  // Products([this.products = const []]);
  Products(this.products, {this.deleteProduct});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        //* --> <Widget> It's a generic type on dart (In this case, A generic array type)
        children: <Widget>[
          //* --> On Dart, When use a dot notation, it means an constuctor, accessing the wanted feature
          Image.asset(
            products[index]['image'],
          ),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                //* Navigator can be used because lives under the MaterialApp()
                //* And MaterialApp() is imported by flutter/material
                //* MaterialPageRoute() gives the transaction effects
                //! onPressed: () => Navigator.push( <T>
                //! old way
                // onPressed: () => Navigator.push<bool>(
                //         //* The push method is a Generic, so it can be configured any type of data
                //         //! THe push method return a Future method
                //         //! This Future behaves same as a Javascript Promise
                //         context,
                //         MaterialPageRoute(
                //             builder: (BuildContext context) => ProductPage(
                //                 products[index]['title'],
                //                 products[index]['image']))).then((bool value) {
                //       if (value) {
                //         deleteProduct(index);
                //       }
                //     }),
                onPressed: () => Navigator.pushNamed<bool>(
                            context, '/product/' + index.toString())
                        .then((bool value) {
                      if (value) {
                        deleteProduct(index);
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards;

    if (products.length > 0) {
      productCards = ListView.builder(
          itemBuilder: _buildProductItem, itemCount: products.length);
    } else {
      productCards = Center(
        child: Text('No Products were found'),
      );
    }
    //! Never return NULL, the build method does not accept null
    //! Instead, return a `Container()` empty (This is valid code, don't impact performance or anything either)
    //? E.g:
    //? } else {
    //?   productCards = Container();
    //? }
    //? return productCards;
    //?
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}

//* Ternary example
//   @override
//   Widget build(BuildContext context) {
//     return productsItem.length > 0
//         /? ListView.builder(itemBuilder: _productListItem, itemCount: products.length)
//         : Center(
//             child: Text('No Products found'),
//           );
//   }
// }

//* old way
//   @override
//   Widget build(BuildContext context) {

//     return ListView( //* For performance purpuses, it will be called ListView.builder()
//         children: productsItem //* List view no use children property
//             .map((element) => Card(
//                   child: Column(
//                     //* --> <Widget> It's a generic type on dart (In this case, A generic array type)
//                     children: <Widget>[
//                       //* --> On Dart, When use a dot notation, it means an constuctor, accessing the wanted feature
//                       Image.asset(
//                         'assets/food.jpg',
//                       ),
//                       Text(element)
//                     ],
//                   ),
//                 ))
//             .toList());
//   }
// }

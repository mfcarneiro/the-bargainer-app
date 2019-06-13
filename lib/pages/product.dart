import 'package:flutter/material.dart';
import 'dart:async'; //! Need to import to be able to use Future method

// Widgets
import '../widgets/products/price_chip.dart';
import '../widgets/basic_widgets/defaul_title.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage({this.title, this.imageUrl, this.price, this.description});

  @override
  Widget build(BuildContext context) {
    //! WillPopScope will wrap the widget to handle the back button of android and Toolbar
    //! When implemented this feature, will block by default the navigation
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Product details'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Image.asset(
                  imageUrl,
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
                                    child: DefaultTitle(title: title)),
                                PriceChip(price: price),
                              ],
                            ),
                            Text(
                              description,
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
          ),
        ));
  }
}

// _showWarningDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Delete the current item?"),
//           content: Text("This Action can not be undone!"),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             RaisedButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 //! Passing the `true` value that indicates for the route that is expecting a Future (Promise) value
//                 //! to erase the current product
//                 Navigator.pop(context, true);
//               },
//             )
//           ],
//         );
//       });
// }

import 'package:flutter/material.dart';
import 'dart:async'; //! Need to import to be able to use Future method

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

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
              title: Text('Product Details'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(this.imageUrl),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(this.title),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Delete Product'),
                    onPressed: () => _showWarningDialog(context),
                  ),
                )
              ],
            )));
  }
}

_showWarningDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete the current item?"),
          content: Text("This Action can not be undone!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                //! Passing the `true` value that indicates for the route that is expecting a Future (Promise) value
                //! to erase the current product
                Navigator.pop(context, true);
              },
            )
          ],
        );
      });
}

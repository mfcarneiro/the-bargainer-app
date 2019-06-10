import "package:flutter/material.dart";

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage({this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _productName;
  num _productPrice;
  String _productDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        //! ListView also works to prevent some overflow screen issues
        //! E.g: open the keyboard and limitating the screen space (because the keyboard also fills the current screen, causing this error)
        child: ListView(children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                onChanged: (String value) {
                  setState(() {
                    _productName = value;
                  });
                },
              )),
          Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.attach_money)),
                onChanged: (String value) {
                  setState(() {
                    _productPrice = num.parse(value);
                  });
                },
              )),
          Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                onChanged: (String value) {
                  setState(() {
                    _productDescription = value;
                  });
                },
              )),
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text("Save product"),
            onPressed: () {
              final Map<String, dynamic> newProduct = {
                'image': 'assets/food.jpg',
                'title': _productName,
                'price': _productPrice,
                'description': _productDescription
              };
              //! With a StateFullWidget, we can bind the constructor parameters with `widget` property
              widget.addProduct(newProduct);

              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ]));
  }
}

//* TextField
//* -> Is used InputDecoration class to configure all the behavior and styling
//* -> Can be changed the keyboard type with TextInputType to automatically shows a numbered or text
//* -> onChanged: it's a data biding, through setState() to updating textField every time that is used.

//? Wether adding a Container to wrap the TextFields, we can add the SizeBox() widget (easiest solution)

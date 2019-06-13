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

  Widget _buildNameTextField() {
    return TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
        onChanged: (String value) {
          setState(() {
            _productName = value;
          });
        });
  }

  Widget _buildPriceTextField() {
    return TextField(
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: false),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Price',
            prefixIcon: Icon(Icons.attach_money)),
        onChanged: (String value) {
          setState(() {
            _productPrice = num.parse(value);
          });
        });
  }

  Widget _buildDescriptionTextField() {
    return TextField(
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
    );
  }

  void _submitProduct() {
    final Map<String, dynamic> newProduct = {
      'image': 'assets/food.jpg',
      'title': _productName,
      'price': _productPrice,
      'description': _productDescription
    };
    //! With a StateFullWidget, we can bind the constructor parameters with `widget` property
    widget.addProduct(newProduct);

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    double _deviceListPaddingTarget(BuildContext context,
        {double baseTargetScreenSize,
        double screenTarget,
        double maximumScreenSize}) {
      double deviceWidth = MediaQuery.of(context).size.width;

      double target = deviceWidth > screenTarget
          ? baseTargetScreenSize
          : deviceWidth * maximumScreenSize;

      double targetPadding = (deviceWidth - screenTarget);

      return targetPadding;
    }

    return Container(
        margin: EdgeInsets.all(8.0),
        //! ListView also works to prevent some overflow screen issues
        //! E.g: open the keyboard and limiting the screen space (because the keyboard also fills the current screen, causing this error)
        child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: _deviceListPaddingTarget(context,
                        screenTarget: 500.0,
                        baseTargetScreenSize: 550.0,
                        maximumScreenSize: 0.95) /
                    2),
            children: <Widget>[
              //! With a ListView, we can not manipulate trough a Container with with property
              //! By default, a ListView always will fit all the room for width/height sizes
              //! It will be needed a padding to control the internal list space

              Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: _buildNameTextField()),
              Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: _buildPriceTextField()),
              Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: _buildDescriptionTextField()),
              RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text("Save product"),
                onPressed:
                    _submitProduct, // remember! -> only referencing the method, passing the name, not call with () (working directly with a Widget)
              ),
            ]));
  }
}

//* TextField
//* -> Is used InputDecoration class to configure all the behavior and styling
//* -> Can be changed the keyboard type with TextInputType to automatically shows a numbered or text
//* -> onChanged: it's a data biding, through setState() to updating textField every time that is used.

//? Wether adding a Container to wrap the TextFields, we can add the SizeBox() widget (easiest solution)

import "package:flutter/material.dart";

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
//  String _productName;
//  num _productPrice;
//  String _productDescription; \/

// -> Using a Form now, we can create a Map to hold all the fields and contents
  final Map<String, dynamic> _formData = {
    'image': 'assets/food.jpg',
    'title': null,
    'price': null,
    'description': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPageContent(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // This ensures the keyboard will close automatically when clicked on some screen areas.
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(8.0),
            //! ListView also works to prevent some overflow screen issues
            //! E.g: open the keyboard and limiting the screen space (because the keyboard also fills the current screen, causing this error)
            child: Form(
                //! -> binds the onSave method on TextFormField
                key: _formKey,
                child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: _deviceListPaddingTarget(
                            context,
                            screenTarget: 500.0,
                            baseTargetScreenSize: 550.0,
                            maximumScreenSize: 0.95,
                          ) /
                          2,
                    ),
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
                    ]))));
  }

  String notEmptyProduct({String fieldName}) {
    if (widget.product == null) {
      return '';
    }

    dynamic currentField = widget.product[fieldName];

    if (currentField is double) {
      return currentField.toString();
    }

    return currentField;
  }

  Widget _buildNameTextField() {
    return TextFormField(
      initialValue: notEmptyProduct(fieldName: 'title'),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'The title name should not be empty';
        } else if (value.length < 5) {
          return 'The title name should have at least 5 characters';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue: notEmptyProduct(fieldName: 'price'),
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: false),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Price',
          prefixIcon: Icon(Icons.attach_money)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'The Price should not be empty';
        }
        //! -> RegExp needs the 'r' character to indicates that will receive a regular expression string
        if (RegExp(r'^(-?[1-9]+\\d*([.]\\d+)?)$|^(-?0[.]\\d*[1-9]+)$|^0$')
            .hasMatch(value)) {
          return 'The Only numbers';
        }
      },
      onSaved: (String value) {
        // As known, the 'setState()' will updates every time when the value is changed
        // Using the 'TextFormField' is not needed anymore,
        // Now only verify when the submit method is triggered
        // -> The behavior will persist, is saving the given input, but in no longer re-render the whole form
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      initialValue: notEmptyProduct(fieldName: 'description'),
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'The Description should not be empty';
        } else if (value.length <= 8) {
          return 'The Description should have at least 8 caracters';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  void _submitProduct() {
    // _formKey.currentState.validate() will only allow when all the fields are fulfilled correctly
    if (!_formKey.currentState.validate()) return;

    // -> this allow now to use onSave() on each TextFormField added (two-way data binding)
    //! With a StateFullWidget, we can bind the constructor parameters with `widget` property
    _formKey.currentState.save();

    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/home');
  }

  double _deviceListPaddingTarget(BuildContext context,
      {double baseTargetScreenSize,
      double screenTarget,
      double maximumScreenSize}) {
    double deviceWidth = MediaQuery.of(context).size.width;

    double target = deviceWidth > screenTarget
        ? baseTargetScreenSize
        : deviceWidth * maximumScreenSize;

    return (deviceWidth - target);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return _buildPageContent(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit contact'),
      ),
      body: _buildPageContent(context),
    );
  }
}

//* TextField
//* -> Is used InputDecoration class to configure all the behavior and styling
//* -> Can be changed the keyboard type with TextInputType to automatically shows a numbered or text
//* -> onChanged: it's a data biding, through setState() to updating textField every time that is used.

//? Wether adding a Container to wrap the TextFields, we can add the SizeBox() widget (easiest solution)

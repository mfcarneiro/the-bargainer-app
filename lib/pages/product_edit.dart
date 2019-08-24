import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

import '../scoped_models/scoped_main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
// -> Using a Form now, we can create a Map to hold all the fields and contents
  final Map<String, dynamic> _formData = {
    'image':
        'https://static3.depositphotos.com/1005741/195/i/950/depositphotos_1950369-stock-photo-colorful-licorice-candy.jpg',
    'title': null,
    'price': null,
    'description': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPageContent(BuildContext context, Product product) {
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
                      //! With a ListView, we can not manipulate trough a Container with 'width' property
                      //! By default, a ListView always will fit all the room for width/height sizes
                      //! It will be needed a padding to control the internal list space
                      Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: _buildNameTextField(product)),
                      Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: _buildPriceTextField(product)),
                      Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: _buildDescriptionTextField(product)),
                      _buildSubmitButton()
                    ]))));
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.getLoadingProcess
          ? Center(child: CircularProgressIndicator())
          : RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () => _submitProduct(
                  model.addProduct,
                  model.updateProduct,
                  model.setSelectedProductId,
                  model.getSelectedProductIndex));
    });
  }

  Widget _buildNameTextField(Product product) {
    return TextFormField(
      initialValue: product?.title ?? '',
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

  _buildPriceTextField(Product product) {
    // '??' null checker example
    //  String initValue = '' ?? product.price.toString();

    return TextFormField(
      initialValue: product?.price == null ? '' : product?.price.toString(),
      //! .digitsOnly will ignore the dot/comma.
      //? input formatter: [WhitelistingTextInputFormatter.digitsOnly],
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
        //! As known, the 'setState()' will updates every time when the value is changed
        //! Using the 'TextFormField' is not needed anymore,
        //! Now only verify when the submit method is triggered
        //! -> The behavior will persist, is saving the given input, but in no longer re-render the whole form
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      initialValue: product?.description ?? '',
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

  void _submitProduct(Function addProduct, Function updateProduct,
      Function setSelectedProduct, int selectedProductIndex) {
    //! formKey.currentState.validate() will only allow when all the fields are fulfilled correctly
    if (!_formKey.currentState.validate()) return;

    //! -> this allow now to use onSave() on each TextFormField added (two-way data binding)
    //! With a StateFullWidget, we can bind the constructor parameters with `widget` property
    _formKey.currentState.save();

    if (selectedProductIndex == -1) {
      addProduct(_formData['image'], _formData['title'],
              _formData['description'], _formData['price'])
          .then((bool sucess) {
        if (!sucess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Oops!'),
                content: Text('Please, Try again later'),
                actions: <Widget>[
                  RaisedButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.of(context).pop())
                ],
              );
            },
          );
        }

        navigateTo(context, path: '/');
      }).then((_) => setSelectedProduct(null));
    } else {
      updateProduct(_formData['image'], _formData['title'],
              _formData['description'], _formData['price'])
          .then((_) => navigateTo(context, path: '/')
              .then((_) => setSelectedProduct(null)));
    }
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

  Future navigateTo(BuildContext contex, {@required String path}) {
    return Navigator.pushReplacementNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (model.getSelectedProductIndex == -1) {
        return _buildPageContent(context, model.getSelectedProduct);
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Edit contact'),
        ),
        body: _buildPageContent(context, model.getSelectedProduct),
      );
    });
  }
}

//* TextField
//* -> Is used InputDecoration class to configure all the behavior and styling
//* -> Can be changed the keyboard type with TextInputType to automatically shows a numbered or text
//* -> onChanged: it's a data biding, through setState() to updating textField every time that is used.

//? Wether adding a Container to wrap the TextFields, we can add the SizeBox() widget (easiest solution)

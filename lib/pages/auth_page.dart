import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/auth.dart';

import '../scoped_models/scoped_main.dart';

class AuthPage extends StatefulWidget {
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _loginInputs = {'email': null, 'password': null};
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.amberAccent.withOpacity(0.8), BlendMode.dstATop));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      //! Controller gives input value from the textField
      //! By deafult, Flutter automatically do this 'control"
      //! But can be changed for own needs
      controller: _emailTextController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'The email address should not be empty';
        }

        if (value.length < 6) {
          return 'The email should have at least 6 characters';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Need to be a valid email';
        }
      },
      onSaved: (String value) {
        _loginInputs['email'] = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordTextController,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'The password address should not be empty';
        }

        if (value.length < 6) {
          return 'The password should have at least 6 characters';
        }
      },
      onSaved: (String value) {
        _loginInputs['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Confirm Password",
        border: OutlineInputBorder(),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'The password address should not be empty';
        }

        if (value.length < 6) {
          return 'The password should have at least 6 characters';
        }

        if (_passwordTextController.text != value) {
          return 'The given password does not match!';
        }
      },
      onSaved: (String value) {
        _loginInputs['password'] = value;
      },
    );
  }

  void _submitLogin(
    Function authenticate,
  ) async {
    Map<String, dynamic> successInformation;

    if (!_loginForm.currentState.validate()) return;

    _loginForm.currentState.save();

    successInformation = await authenticate(
        _loginInputs['email'], _loginInputs['password'], _authMode);

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('A error occoured!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    }
  }

  double _deviceWidthTarget(BuildContext context,
      {double baseTargetScreenSize,
      double screenTarget,
      double maximumScreenSize}) {
    double deviceWidth = MediaQuery.of(context).size.width;

    double target = deviceWidth > screenTarget
        ? baseTargetScreenSize
        : deviceWidth * maximumScreenSize;

    return target;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: Form(
                key: _loginForm,
                child: Container(
                  // using Alignment on other screen sizes
                  // Allow to set the same "alignment" for screen different sizes
                  decoration: BoxDecoration(image: _buildBackgroundImage()),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 50),
                        width: 200,
                        child: Column(children: <Widget>[
                          Image.asset(
                            'assets/ic_launcher.png',
                          ),
                        ]),
                      ),
                      // Can be adjust the size of the textFields with MediaQuery class
                      // MediaQuery allows to target the desire orientation or width/height of the screen
                      SingleChildScrollView(
                        child: Container(
                          // Width will hold the MediaQuery information and display the correct screen size
                          width: _deviceWidthTarget(context,
                              baseTargetScreenSize: 550.0,
                              screenTarget: 500.0,
                              maximumScreenSize: 0.95),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: _buildEmailTextField(),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: _buildPasswordField(),
                              ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: _authMode == AuthMode.SignUp
                                      ? _buildPasswordConfirmField()
                                      : Container()),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: FlatButton(
                                child: Text(
                                  'Switch to ${_authMode == AuthMode.Login ? 'SignUp' : 'Login'}',
                                ),
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    _authMode = _authMode == AuthMode.Login
                                        ? AuthMode.SignUp
                                        : AuthMode.Login;
                                  });
                                }),
                          ),
                          ScopedModelDescendant<MainModel>(builder:
                              (BuildContext context, Widget child,
                                  MainModel model) {
                            return model.getLoadingProcess
                                ? CircularProgressIndicator()
                                : RaisedButton(
                                    child: Container(
                                      child: _authMode == AuthMode.Login
                                          ? Text('Login')
                                          : Text('Sign Up'),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(05)),
                                    color: Theme.of(context).accentColor,
                                    textColor: Colors.white,
                                    onPressed: () =>
                                        _submitLogin(model.authenticateUser));
                          }),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}

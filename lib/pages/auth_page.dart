import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.amberAccent.withOpacity(0.8), BlendMode.dstATop));
  }

  Widget _buildEmailTextField({String email}) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          email = value;
        });
      },
    );
  }

  Widget _buildPasswordField({String password}) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
      onChanged: (String value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  void _submitLogin() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  double _deviceWidthTarget(BuildContext context,
      {double baseTargetScreenSize, double screenTarget, double maximumScreenSize}) {
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
            body: Container(
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
                'assets/bargaining-icon.png',
              ),
            ]),
          ),
          Center(
            // Can be adjust the size of the textFields with MediaQuery class
            // MediaQuery allows to target the desire orientation or width/height of the screen
            child: SingleChildScrollView(
              child: Container(
                // Width will hold the MediaQuery information and display the correct screen size
                width: _deviceWidthTarget(context, baseTargetScreenSize: 550.0,
                    screenTarget: 500.0, maximumScreenSize: 0.95),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: _buildEmailTextField(email: _emailValue),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: _buildPasswordField(password: _passwordValue),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                  child: Container(
                    child: Text('Login'),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(05)),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: _submitLogin)
            ],
          )
        ],
      ),
    )));
  }
}

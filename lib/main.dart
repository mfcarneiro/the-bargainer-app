//! In Flutter, never change the name of this file always will be 'main'
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/product.dart';

import './scoped_models/scoped_main.dart';

import './pages/auth_page.dart';
import './pages/product.dart';
import './pages/product_admin.dart';
import './pages/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final MainModel _mainModel = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _mainModel.passwordlessSignIn();
    _mainModel.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // -> Creating this 'ScopedModel' Widget, ensures that Scoped-model will be inject
    // -> Now can be used the reference in other widgets that need the ProductModel instance

    return ScopedModel<MainModel>(
        model: _mainModel, // -> Create the 'injection'
        child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepOrange),
          routes: {
            '/': !_isAuthenticated
                ? _createRoute(AuthPage())
                : _createRoute(ProductsPage(model: _mainModel)),
            '/admin': !_isAuthenticated
                ? _createRoute(AuthPage())
                : _createRoute(ProductAdminPage(model: _mainModel))
          },
          //! Only is triggered when not configured on the main `routes:` attribute
          onGenerateRoute: (RouteSettings routerSettings) {
            if (!_isAuthenticated) {
              return MaterialPageRoute<bool>(builder: _createRoute(AuthPage()));
            }

            final List<String> routerPath = routerSettings.name.split('/');

            if (routerPath[0] != '') {
              return null;
            }

            if (routerPath[1] == 'product') {
              final String productId = routerPath[2];
              final Product product =
                  _mainModel.allProducts.firstWhere((Product product) {
                return product.id == productId;
              });

              return MaterialPageRoute<bool>(
                  builder: !_isAuthenticated
                      ? _createRoute(AuthPage())
                      : _createRoute(ProductPage(product: product)));
            }

            return null;
          },
          //! Sort of fallback page to redirect when some route was not more valid
          onUnknownRoute: (RouteSettings unknownRouterSettings) {
            return MaterialPageRoute(
                builder: !_isAuthenticated
                    ? _createRoute(AuthPage())
                    : _createRoute(ProductsPage(model: _mainModel)));
          },
        ));
  }
}

Function _createRoute(Widget page) {
  return (BuildContext context) => page;
}

//! In Flutter, never change the name of this file always will be 'main'
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Widgets
import './pages/auth_page.dart';
import './pages/product.dart';
import './pages/product_admin.dart';
import './pages/products.dart';

// Scoped Models
import './scoped_models/scoped_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // -> Creating this 'ScopedModel' Widget, ensures that Scoped-model will be inject
    // -> Now can be used the reference in other widgets that need the ProductModel instance
    return ScopedModel<MainModel>(
        model: MainModel(), // -> Create the 'injection'
        child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepOrange),
          routes: {
            '/': _createRoute(AuthPage()),
            '/home': _createRoute(ProductsPage()),
            '/admin': _createRoute(ProductAdminPage())
          },
          //! Only is triggered when not configured on the main `routes:` attribute
          onGenerateRoute: (RouteSettings routerSettings) {
            final List<String> routerPath = routerSettings.name.split('/');

            if (routerPath[0] != '') {
              return null;
            }

            if (routerPath[1] == 'product') {
              final int index = int.parse(routerPath[2]);
              return MaterialPageRoute<bool>(
                  builder: _createRoute(ProductPage(index)));
            }

            return null;
          },
          //! Sort of fallback page to redirect when some route was not more valid
          onUnknownRoute: (RouteSettings unknownRouterSettings) {
            return MaterialPageRoute(builder: _createRoute(ProductsPage()));
          },
        ));
  }
}

Function _createRoute(Widget page) {
  return (BuildContext context) => page;
}

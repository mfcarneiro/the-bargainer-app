//! In Flutter, never change the name of this file always will be 'main'
import 'package:flutter/material.dart';
import './pages/auth_page.dart';

// Routes
import './pages/product_admin.dart';
import './pages/products.dart';
import './pages/product.dart';

//* This method convetion it's a good practice
//* But with the method ONLY returns one thing
// void main() {
//   runApp(MyApp());
// }

// * Can be used the "fat arrow" ->
void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   //! StatefulWidget always works with two objects (classes)
//   @override
//   State<StatefulWidget> createState() {
//     return _MyAppState();
//   }
// }

//! -> StatelessWidget only works with external data
//! -> Does not accept changes and will not fire up when receive internal or data changes
//! --> Underscore `_` It is the same convention to private access
// class _MyAppState extends State<MyApp> {
//! -> Flutter always will try to reach the 'build' method
//!-> Because the framework will understand this 'build method' and try to drawn something on the screen
//   @override
//   Widget build(BuildContext context) {
//! --> Inside of the build method, it will be only returned another widget (It's a rule)
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text('The Bargainer'),
//             ),
//             body: Column(children: <Widget>[

//             ])));
//   }
// }

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange),
      // home: AuthPage(),
      //! Can be use only `admin` but the slash is a indentifier
      routes: {
        //! Using the `/` it's the same way of using home attribute, use one or another, both will not work
        '/': _createRoute(AuthPage()),
        '/home': _createRoute(ProductsPage(products: _products)),
        '/admin': _createRoute(ProductAdminPage(
            addProduct: _addProduct, deleteProduct: _deleteProduct))
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
              builder: (BuildContext context) => ProductPage(
                    title: _products[index]['title'],
                    imageUrl: _products[index]['image'],
                    description: _products[index]['description'],
                    price: _products[index]['price'],
                  ));
        }

        return null;
      },
      //! Sort of fallback page to redirect when some route was not more valid
      onUnknownRoute: (RouteSettings unknownRouterSettings) {
        return MaterialPageRoute(
            builder: _createRoute(ProductsPage(products: _products)));
      },
    );
  }
}

Function _createRoute(Widget page) {
  return (BuildContext context) => page;
}

//* Since we need to control the products, the product class will be controlled on the main file
//* Turning MyApp class into a statefulWidget
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           brightness: Brightness.light,
//           primarySwatch: Colors.deepPurple,
//           accentColor: Colors.deepOrange),
//       // home: AuthPage(),
//       //! Can be use only `admin` but the slash is a indentifier
//       routes: {
//         //! Using the `/` it's the same way of using home attribute, use one or another, both will not work
//         '/': _createRoute(ProductsPage()),
//         '/admin': _createRoute(ProductAdminPage())
//       },
//       //! Only is triggered when not configured on the main `routes:` attribute
//       onGenerateRoute: (RouteSettings routerSettings) {
//         final List<String> routerPath = routerSettings.name.split('/');

//         if (routerPath[0] != '') {
//           return null;
//         }

//         if (routerPath[2] == 'product') {
//           final int index = int.parse(routerPath[2]);
//           return MaterialPageRoute(
//               builder: (BuildContext context) => ProductPage(
//                   products[index]['title'], products[index]['image']));
//         }

//         return null;
//       },
//     );
//   }
// }

//* Flutter works similar to Android, having a stack of pages  (like Activicty stack)
//* Each route that was pushed, go on top of the stack

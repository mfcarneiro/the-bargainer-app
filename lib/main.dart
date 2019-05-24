// In Flutter, never change the name of this file always will be 'main'
import 'package:flutter/material.dart';
import './pages/home.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepOrange),
        home: HomePage());
  }
}

//* Flutter works similar to Android, having a stack of pages  (like Activicty stack)
//* Each route that was pushed, go on top of the stack


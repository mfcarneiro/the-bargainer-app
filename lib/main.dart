// In Flutter, never change the name of this file always will be 'name'
import 'package:flutter/material.dart';

// *This method convetion it's a good practice
// * But with the method ONLY returns one thing
// * Can be used the "fat arrow" ->
// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // ! -> Flutter always will try to reach the 'build' method
  // !-> Because the framework will understand this 'build method' and try to drawn something on the screen
  @override
  Widget build(BuildContext context) {
    // ! --> Inside of the build method, it will be only returned another widget (It's a rule)
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('The Bargainer'),
      ),
      body: Card(
        child: Column(
          // * --> <Widget> It's a generic type on dart (In this case, A generic array type)
          children: <Widget>[
            // * --> On Dart, When use a dot notation, it means an constuctor, assesing the wanted feature
            Image.asset(
              'assets/food.jpg',
            ),
            Text('Food Paradise')
          ],
        ),
      ),
    ));
  }
}

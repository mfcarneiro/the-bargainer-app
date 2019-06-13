import 'package:flutter/material.dart';

class PriceChip extends StatelessWidget {
  final double price;

  const PriceChip({this.price});

  @override
  Widget build(BuildContext context) {
    return Chip(
        avatar: Icon(
          Icons.attach_money,
          size: 20,
          color: Colors.white,
        ),
        label: Text(price.toString()),
        backgroundColor: Colors.deepPurpleAccent,
        labelStyle: TextStyle(
          color: Colors.white,
        ));
  }
}

import 'package:flutter/material.dart';

class AddressChip extends StatelessWidget {
  final String label;

  AddressChip({this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: Icon(Icons.location_on),
    );
  }
}

import 'package:flutter/material.dart';

class Product {
  final String id;
  final String image;
  final String title;
  final double price;
  final String description;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product(
      {@required this.id,
      @required this.image,
      @required this.title,
      @required this.price,
      @required this.description,
      @required this.userEmail,
      @required this.userId,
      this.isFavorite});
}

// import 'dart:typed_data';

import 'package:flutter/material.dart';

class AddProductDto {
  AddProductDto({
    required this.title,
    required this.description,
    required this.price,
    required this.isActive,
    required this.color,
    this.image,
  });
  final String title;
  final String description;
  final String price;
  final bool isActive;
  final String? image;
  final List<String> color;

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "isActive": isActive,
        "image": image,
        "colors": color
      };
}

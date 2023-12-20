import 'package:flutter/material.dart';

class Food {
  final String name;
  final Image image;
  final Map<String, dynamic> nutriments;

  Food({
    required this.name,
    required this.image,
    required this.nutriments,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['product']['product_name'],
      image: Image.network(
        json['product']['image_front_url'],
        width: 100,
        height: 100,
      ),
      nutriments: json['product']['nutriments'],
    );
  }

  String get formattedName {
    List<String> words = name.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    if (words.length > 2) {
      words = words.sublist(0, 2);
    }
    return words.join(' ');
  }
}

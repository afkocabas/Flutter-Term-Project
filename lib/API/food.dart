import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Food {
  final String id;
  final String name;
  final Image image;
  final Map<String, dynamic> nutriments;
  final String imageURL;

  Food(
      {required this.id,
      required this.name,
      required this.image,
      required this.nutriments,
      required this.imageURL});

  factory Food.fromJson(Map<String, dynamic> json) {
    var id = const Uuid().v1();
    return Food(
      id: id,
      name: json['product']['product_name'],
      imageURL: json['product']['image_front_url'],
      image: Image.network(
        json['product']['image_front_url'],
        width: 100,
        height: 100,
      ),
      nutriments: json['product']['nutriments'],
    );
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'],
      imageURL: map['imageURL'],
      image: Image.network(
        map['imageURL'],
        width: 100,
        height: 100,
      ),
      nutriments: map['nutriments'],
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

  String get calories {
    return nutriments['energy-kcal_100g'].toString();
  }

  // make it a map so we can store it in firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'imageURL': imageURL,
      'nutriments': nutriments,
    };
  }
}

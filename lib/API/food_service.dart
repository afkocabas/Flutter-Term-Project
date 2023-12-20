import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:project/API/food.dart';

class FoodService {
  static Future<Food> fetchFood(String barcode) async {
    final url = "https://world.openfoodfacts.org/api/v0/product/$barcode.json";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Food.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load food');
    }
  }
}

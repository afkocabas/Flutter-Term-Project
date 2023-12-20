import 'package:flutter/material.dart';
import 'package:project/Widgets/food_card.dart';

import '../API/food.dart';

class ListOfFoods extends StatelessWidget {
  final List<Food> foods;
  const ListOfFoods({required this.foods, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return FoodCard(food: foods[index]);
      },
    );
  }
}

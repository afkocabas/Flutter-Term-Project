import 'package:flutter/material.dart';
import 'package:project/API/food.dart';
import 'package:project/Pages/food_details_page.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({required this.food, super.key});

  void displayFoodDetails(BuildContext context, Food food) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FoodDetailsPage(food: food);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        displayFoodDetails(context, food);
      },
      child: Card(
        child: ListTile(
          leading: food.image,
          title: Text(food.formattedName),
        ),
      ),
    );
  }
}

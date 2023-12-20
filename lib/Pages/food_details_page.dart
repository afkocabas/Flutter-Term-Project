import 'package:flutter/material.dart';
import 'package:project/API/food.dart';

class FoodDetailsPage extends StatelessWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      // create a list view builder to display nutriments information of food
      child: ListView.builder(
        itemCount: food.nutriments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(food.nutriments[index].name),
            trailing: Text(food.nutriments[index].value),
          );
        },
      ),
    );
  }
}

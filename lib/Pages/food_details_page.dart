import 'package:flutter/material.dart';
import 'package:project/API/food.dart';

class FoodDetailsPage extends StatelessWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      // create a list view builder to display nutriments information of food
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(thickness: 0),
        itemCount: food.nutriments.length,
        itemBuilder: (context, index) {
          MapEntry entry = food.nutriments.entries.elementAt(index);
          return ListTile(
            tileColor: Colors.green.shade100,
            textColor: const Color.fromARGB(255, 7, 52, 8),
            title: Text(entry.key as String),
            trailing: Text(
              entry.value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}

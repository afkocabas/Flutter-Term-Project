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
      child: Column(
        children: [
          const Text(
            "Nutriments",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 55, 10),
            ),
          ),
          const Divider(
            thickness: 2,
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                thickness: 0,
                height: 10,
              ),
              itemCount: food.nutriments.length,
              itemBuilder: (context, index) {
                MapEntry entry = food.nutriments.entries.elementAt(index);
                return ListTile(
                  textColor: Colors.green.shade900,
                  title: Text(entry.key as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  trailing: Text(
                    entry.value.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

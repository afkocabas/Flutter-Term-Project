import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project/API/food.dart';
import 'package:project/Pages/food_details_page.dart';
import 'package:provider/provider.dart';

import '../User/user_state.dart';

class FoodCard extends StatelessWidget {
  final Map<int, dynamic> novaColors = {
    1: Colors.green.shade100,
    2: Colors.yellow.shade100,
    3: Colors.orange.shade100,
    4: Colors.red.shade100,
  };
  final Food food;
  final int novaGroup;
  FoodCard({required this.food, super.key})
      : novaGroup = food.nutriments['nova-group'];

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
    final userId = Provider.of<UserState>(context).userId;
    return Dismissible(
      key: Key(food.id),
      onDismissed: (direction) async {
        try {
          await Provider.of<UserState>(context, listen: false)
              .removeFood(userId, food);
        } catch (e) {
          print(e);
        }
      },
      child: InkWell(
        onTap: () {
          displayFoodDetails(context, food);
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            tileColor:
                novaGroup != null ? novaColors[novaGroup] : Colors.grey[100],
            leading: SizedBox(height: 50, width: 50, child: food.image),
            trailing: Text(
              '${food.calories} kcal',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              food.formattedName,
            ),
          ),
        ),
      ).animate().fadeIn().slideX(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project/API/food.dart';
import 'package:project/API/food_service.dart';
import 'package:project/User/user_state.dart';
import 'package:provider/provider.dart';

enum FoodState { initial, loading, loaded, notFound }

class SearchMealPage extends StatefulWidget {
  const SearchMealPage({Key? key}) : super(key: key);

  @override
  State<SearchMealPage> createState() => _SearchMealPageState();
}

// a function to add searched food to the database

class _SearchMealPageState extends State<SearchMealPage> {
  String barcode = '';
  Food? food;
  FoodState foodState = FoodState.initial;

  void addFoodToDatabase(Food food) async {
    UserState userState = Provider.of<UserState>(context, listen: false);
    print(userState.userId);
    String userId = userState.userId;
    await userState.addFood(userId, food);
  }

  Widget _buildFood() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        food!.image,
        const SizedBox(height: 10),
        Text(
          food!.formattedName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            addFoodToDatabase(food!);
            Navigator.of(context).pop();
          },
          child: const Text('Add Food'),
        ),
        Text(
          'Calories: ${food!.calories} kcal',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ].animate().fadeIn().slideY(),
    );
  }

  Widget _buildFoodState() {
    switch (foodState) {
      case FoodState.initial:
        return const SizedBox.shrink();
      case FoodState.loading:
        return const CircularProgressIndicator();
      case FoodState.loaded:
        return _buildFood();
      case FoodState.notFound:
        return const Text('Food not found');
    }
  }

  void _searchFood() async {
    setState(() {
      foodState = FoodState.loading;
    });
    try {
      final food = await FoodService.fetchFood(barcode);
      setState(() {
        this.food = food;
        foodState = FoodState.loaded;
      });
    } catch (e) {
      setState(() {
        foodState = FoodState.notFound;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Enter The Barcode',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          PinCodeTextField(
            appContext: context,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            onCompleted: (value) {
              barcode = value;
            },
            length: 13,
            pinTheme: PinTheme(
              activeColor: Colors.green,
              inactiveColor: Colors.green,
              selectedColor: Colors.green.shade300,
              borderRadius: BorderRadius.circular(5),
              fieldWidth: 10,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _searchFood,
            child: const Text('Search Food'),
          ),
          const SizedBox(height: 20),
          _buildFoodState()
              .animate()
              .fadeIn()
              .slideY(duration: const Duration(milliseconds: 500)),
        ],
      ).animate().fade(duration: const Duration(milliseconds: 500)),
    );
  }
}

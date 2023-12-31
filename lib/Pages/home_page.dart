import 'package:flutter/material.dart';
import 'package:project/API/food.dart';
import 'package:project/Pages/search_meal_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project/User/user_state.dart';
import 'package:project/Widgets/list_of_foods.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // access to the user state

  void searchFoodScreen(BuildContext context) {
    showModalBottomSheet(
        // make it as wide as the device
        elevation: 50,
        isScrollControlled: true,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.6,
          minWidth: MediaQuery.of(context).size.width,
        ),
        context: context,
        builder: (context) => const SearchMealPage());
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    String email = userState.userEmail;

    List<Food> foodList = userState.foodList;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          disabledElevation: 20,
          elevation: 20,
          shape: const CircleBorder(),
          onPressed: () => searchFoodScreen(context),
          child: const Icon(Icons.qr_code_scanner)),
      drawer: NavigationDrawer(
        elevation: 20,
        shadowColor: Colors.green,
        children: [
          Wrap(
            runSpacing: 10,
            runAlignment: WrapAlignment.center,
            children: [
              // add a header to the drawer but make it thinner
              DrawerHeader(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      const Text(
                        'Food Facts',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // add a divider
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/user');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                  // add delay
                  Future.delayed(const Duration(milliseconds: 100), () {
                    userState.logout();
                  });
                },
              ),
            ],
          ).animate().fade().slideX(),
        ],
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          'Food Facts',
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/home_page_background.png'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListOfFoods(foods: foodList).animate().fadeIn().slideX(),
      ),
    );
  }
}

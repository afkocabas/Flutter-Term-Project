import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

const String aboutText =
    'Welcome to our innovative mobile app designed to make your grocery shopping experience smarter and more informed! With our app, you can effortlessly access detailed information about your favorite food products using their 13-digit barcodes. Simply input the barcode, and voilà – our app fetches comprehensive data from the OpenFoodFacts API, offering you insights into nutritional facts, ingredients, allergens, and much more. But thats not all! You can create a personalized list of your preferred products, ensuring that your next shopping trip is a breeze. Plus, we have integrated Firebase to securely store your user data, so you can seamlessly sync your preferences across devices. Take control of your nutrition and streamline your shopping with our user-friendly app, putting the power of knowledge right at your fingertips. Happy scanning!';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Food Facts'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        // add gradient to the background
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.green.shade100,
              Colors.green.shade50,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'About Food Facts',
              style: TextStyle(
                color: Color.fromARGB(255, 5, 61, 7),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              aboutText,
              style: TextStyle(
                color: Color.fromARGB(255, 5, 61, 7),
                fontSize: 18,
              ),
            ),
          ],
        ).animate().fadeIn(
            duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic),
      ),
    );
  }
}

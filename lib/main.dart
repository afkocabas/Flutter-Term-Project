import 'package:flutter/material.dart';
import 'package:project/Pages/about_page.dart';
import 'package:project/Pages/home_page.dart';
import 'package:project/Pages/log_in_page.dart';
import 'package:project/Pages/sign_up_page.dart';
import 'package:project/User/user_state.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Pages/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LogInPage(),
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => const HomePage(),
          '/user': (context) => const UserPage(),
          '/about': (context) => const AboutPage(),
        },
        title: 'Food Facts',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              elevation: 20,
              shadowColor: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          fontFamily: GoogleFonts.roboto().fontFamily,
          brightness: Brightness.light,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green.shade100,
          ).copyWith(
            primary: Colors.grey,
            secondary: Colors.grey.shade300,
          ),
          appBarTheme: AppBarTheme(
            shadowColor: Colors.green,
            centerTitle: true,
            elevation: 20,
            backgroundColor: const Color.fromARGB(255, 19, 130, 49),
            foregroundColor: Colors.green[50],
          ),
        ),
      ),
    );
  }
}

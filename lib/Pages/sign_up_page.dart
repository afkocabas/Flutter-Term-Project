import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Authentication/authenticaton_service.dart';
import 'package:project/User/user_state.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordObscure = true;
  bool confirmPasswordObscure = true;

  void tooglePasswordObscure() {
    setState(() {
      passwordObscure = !passwordObscure;
    });
  }

  void toogleConfirmPasswordObscure() {
    setState(() {
      confirmPasswordObscure = !confirmPasswordObscure;
    });
  }

  // 1. Create a TextEditingController for each TextField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthenticatonService _authenticatonService = AuthenticatonService();

  void trySignUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    // if the passwords match, try to register with firebase
    User? user = await _authenticatonService.registerWithEmailAndPassword(
        email, password);
    if (user != null && mounted) {
      final userState = Provider.of<UserState>(context, listen: false);
      userState.setUser(user);
      userState.register(email, password);
      Navigator.of(context).pushNamed('/login');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Could not register'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    // 3. Dispose the controllers
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 200,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              // toggle the obscureText property to show/hide text

              controller: _passwordController,
              obscureText: passwordObscure,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: tooglePasswordObscure,
                    icon: const Icon(Icons.visibility)),
              ),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: confirmPasswordObscure,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                    onPressed: toogleConfirmPasswordObscure,
                    icon: const Icon(Icons.visibility)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                elevation: 20,
                shadowColor: Colors.green,
              ),
              onPressed: () {
                trySignUp();
              },
              child: const Text('Sign Up'),
            ),
            const Text(
              "Already have an account?",
              style: TextStyle(fontSize: 15),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                elevation: 20,
                shadowColor: Colors.green,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back),
                  Text('Back to Log In'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

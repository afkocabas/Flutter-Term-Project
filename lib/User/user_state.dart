import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/API/food.dart';
import 'package:project/Authentication/authenticaton_service.dart';

class UserState with ChangeNotifier {
  final AuthenticatonService _authenticatonService = AuthenticatonService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  List<Food>? _foodList;
  User? get user => _user;

  String get userId => _user!.uid;
  String get userEmail => _user!.email!;
  List<Food>? get foodList => _foodList;

  // handle user login
  Future<void> login(String email, String password) async {
    _user =
        await _authenticatonService.signInWithEmailAndPassword(email, password);
    notifyListeners();
  }

  // handle user registration
  Future<void> register(String email, String password) async {
    _user = await _authenticatonService.registerWithEmailAndPassword(
        email, password);
    await _firestore.collection('users').doc(_user!.uid).set({
      'email': _user!.email,
      'uid': _user!.uid,
    });
    // Create
    notifyListeners();
  }

  // handle adding food to the database
  Future<void> addFood(String userId, Food food) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('food')
        .add(food.toMap());
    notifyListeners();
  }

  // handle user logout
  Future<void> logout() async {
    _authenticatonService.signOut();
    notifyListeners();
  }

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

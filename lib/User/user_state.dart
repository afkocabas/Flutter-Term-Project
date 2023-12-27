import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/API/food.dart';
import 'package:project/Authentication/authenticaton_service.dart';

class UserState with ChangeNotifier {
  final AuthenticatonService _authenticatonService = AuthenticatonService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  List<Food> _foodList = [];
  User? get user => _user;

  String get userId => _user!.uid;
  String get userEmail => _user!.email!;
  List<Food> get foodList => _foodList;

  // handle user login
  Future<void> login(String email, String password) async {
    _user =
        await _authenticatonService.signInWithEmailAndPassword(email, password);
    if (_user != null) {
      fetchFood(_user!.uid);
    }
    notifyListeners();
  }

  // handle user registration
  Future<void> register(String email, String password) async {
    _user = await _authenticatonService.registerWithEmailAndPassword(
        email, password);
    if (_user == null) {
      return;
    }
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
    _foodList.add(food);
    notifyListeners();
  }

  // handle getting food from the database and set it to the foodList
  Future<void> fetchFood(String userId) async {
    List<Food> foodList = [];
    final foodSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('food')
        .get();
    foodSnapshot.docs.forEach((food) {
      foodList.add(Food.fromMap(food.data()));
    });
    _foodList = foodList;
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

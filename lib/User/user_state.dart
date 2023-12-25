import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Authentication/authenticaton_service.dart';

class UserState with ChangeNotifier {
  final AuthenticatonService _authenticatonService = AuthenticatonService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;
  String get userId => _user!.uid;
  String get userEmail => _user!.email!;

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
    notifyListeners();
  }

  // handle user logout
  Future<void> logout() async {
    await _authenticatonService.signOut();
    _user = null;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

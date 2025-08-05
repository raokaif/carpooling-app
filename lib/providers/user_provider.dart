import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  String? _userName;
  bool _isLoading = true;

  String? get userName => _userName;
  bool get isLoading => _isLoading;

  UserProvider() {
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (doc.exists && doc.data() != null) {
          _userName = doc['name'] as String?;
        }
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}

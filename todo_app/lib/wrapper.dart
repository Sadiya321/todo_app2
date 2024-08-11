import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/get_started/get_started.dart';
import 'package:todo_app/screens/home_screen.dart';

// Replace with your actual home page widget

class Wrapper extends StatelessWidget {
  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    User? user = FirebaseAuth.instance.currentUser;

    return isLoggedIn && user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while checking status
        } else if (snapshot.hasData && snapshot.data == true) {
          return HomePage(); // Replace with your actual home page widget
        } else {
          return GetStartedPage();
        }
      },
    );
  }
}

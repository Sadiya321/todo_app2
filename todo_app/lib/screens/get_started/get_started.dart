import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Handle error
      print('Error signing in anonymously: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Light background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding around content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Our App!',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800], // Dark text color
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Space between elements
              Text(
                'Get started by signing in anonymously to explore the features of our app.',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.blueGrey[600], // Subtle text color
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30), // Space before the button
              ElevatedButton(
                onPressed: () => _signInAnonymously(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[700], // Button text color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0), // Padding inside the button
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

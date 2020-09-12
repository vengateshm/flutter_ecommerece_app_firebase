import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';
import 'package:flutter_ecommerce_app_firebase/screens/home_screen.dart';
import 'package:flutter_ecommerce_app_firebase/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error ${snapshot.error}.'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // return Scaffold(
            //   body: Center(
            //     child: Text('Firebase app initialized.'),
            //   ),
            // );
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamSnapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${streamSnapshot.error}"),
                      ),
                    );
                  }
                  // Connection state active - Do the user login check inside the
                  // if statement
                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    // Get the user
                    User _user = streamSnapshot.data;
                    // If the user is null, we're not logged in
                    if (_user == null) {
                      // user not logged in, head to login
                      return LoginScreen();
                    } else {
                      // The user is logged in, head to homepage
                      return HomeScreen();
                    }
                  }
                  // Checking the auth state - Loading
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "Checking Authentication...",
                        style: regularHeading,
                      ),
                    ),
                  );
                });
          }
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularProgressIndicator(),
                  Text('Initializing app...')
                ],
              ),
            ),
          );
        });
  }
}

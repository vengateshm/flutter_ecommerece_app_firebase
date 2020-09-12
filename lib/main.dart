import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/screens/landing_screen.dart';
import 'package:flutter_ecommerce_app_firebase/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme:
              GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
      home: LandingScreen(),
    );
  }
}

import 'package:acm_hack_20/screens/home.dart';
import 'package:acm_hack_20/screens/login.dart';
import 'package:acm_hack_20/screens/search_results.dart';
import 'package:acm_hack_20/screens/video_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        VideoScreen.id: (context) => VideoScreen(),
        Results.id: (context) => Results(),
      },
      initialRoute: LoginScreen.id,
    );
  }
}

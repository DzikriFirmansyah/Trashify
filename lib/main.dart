import 'package:flutter/material.dart';
import 'package:trashbin/Opening/tutorial.dart';
import 'package:trashbin/Opening/splash.dart';
import 'package:trashbin/Opening/tutorial2.dart';
import 'package:trashbin/Opening/tutorialScreen.dart';
import 'package:trashbin/profil/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trashify',
      theme: ThemeData(primaryColor: Colors.green),
      home: const TutorialScreen(),
    );
  }
}

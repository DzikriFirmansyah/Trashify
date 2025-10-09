import 'package:flutter/material.dart';
import 'package:trashbin/Opening/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 Cegah duplikasi Firebase App
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "trashbin",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    Firebase.app();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trashify',
      theme: ThemeData(primaryColor: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

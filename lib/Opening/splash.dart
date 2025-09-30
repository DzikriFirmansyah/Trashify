import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:trashbin/Opening/tutorialScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Jalankan setelah build pertama selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TutorialScreen()),
        );
      });
    });



    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),

          // Loading indicator (posisi tengah bawah)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 160),
                child: CircularProgressIndicator(
                  color: Colors.green,
                  strokeWidth: 4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashbin/Main/dashboard.dart';
import 'package:trashbin/Opening/tutorialScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userName');

    // Delay biar splash sempat tampil 3-4 detik
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return; // cek widget masih ada

    if (username != null && username.isNotEmpty) {
      // User sudah ada → langsung ke Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      // User belum ada → ke Tutorial
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TutorialScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),

          // Loading indicator di tengah bawah
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 150),
              child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

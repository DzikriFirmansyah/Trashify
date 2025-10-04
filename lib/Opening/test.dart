import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Stream<List<ConnectivityResult>> connectivityStream;
  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    super.initState();

    // ambil stream koneksi
    connectivityStream = Connectivity().onConnectivityChanged;

    // langsung cek saat masuk splash
    _checkConnection();

    // listen stream koneksi
    subscription = connectivityStream.listen((List<ConnectivityResult> results) {
      final hasConnection = results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (hasConnection) {
        // Jika ada koneksi, lanjut ke halaman berikutnya
        Navigator.pushReplacementNamed(context, '/nextPage');
      } else {
        // Jika tidak ada koneksi, tetap di splash
        debugPrint("Tidak ada koneksi, tetap di splash.");
      }
    });
  }

  // cek awal saat pertama kali splash muncul
  Future<void> _checkConnection() async {
    final results = await Connectivity().checkConnectivity();
    final hasConnection = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);

    if (hasConnection) {
      Navigator.pushReplacementNamed(context, '/nextPage');
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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

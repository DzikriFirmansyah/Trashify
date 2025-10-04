import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashbin/Main/dashboard.dart';
import 'package:trashbin/Opening/tutorialScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
    // start an initial connectivity check and also listen for changes
    _initialCheck();
    _startListening();
  }

  // cek awal sekali ketika splash muncul
  Future<void> _initialCheck() async {
  // kasih delay biar splash sempat tampil minimal 2 detik
  await Future.delayed(const Duration(seconds: 2));

  final connResult = await Connectivity().checkConnectivity();
  final bool hasConnection = _hasConnectionFromEvent(connResult);

  debugPrint('Initial connectivity: $connResult -> hasConnection: $hasConnection');

  if (hasConnection) {
    await _goNextIfNeeded();
  }
  // kalau tidak ada koneksi → tetap stay di splash & tunggu listener
}

  // mulai listen perubahan koneksi
  void _startListening() {
    _subscription = Connectivity().onConnectivityChanged.listen((event) async {
      debugPrint('Connectivity changed event: $event');

      final bool hasConnection = _hasConnectionFromEvent(event);
      if (!hasConnection) {
        debugPrint('No connection -> stay on splash');
        return;
      }

      // ada koneksi: batalkan subscription supaya tidak double-navigate
      await _subscription?.cancel();
      _subscription = null;

      await _goNextIfNeeded();
    });
  }

  // cek SharedPreferences dan navigasi sesuai kondisi
  Future<void> _goNextIfNeeded() async {
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userName');

    // kasih delay minimal 2 detik sebelum navigate
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    if (username != null && username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TutorialScreen()),
      );
    }
  }

  // helper untuk mendeteksi apakah event menunjukkan koneksi aktif
  bool _hasConnectionFromEvent(dynamic event) {
    if (event == null) return false;

    if (event is ConnectivityResult) {
      return event != ConnectivityResult.none;
    }

    if (event is List<ConnectivityResult>) {
      return event.contains(ConnectivityResult.wifi) ||
          event.contains(ConnectivityResult.mobile) ||
          event.contains(ConnectivityResult.ethernet);
    }

    // fallback: jika event adalah Iterable yang bukan List<ConnectivityResult>
    if (event is Iterable) {
      for (final e in event) {
        if (e == ConnectivityResult.wifi ||
            e == ConnectivityResult.mobile ||
            e == ConnectivityResult.ethernet) return true;
      }
    }

    return false;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // background splash
          Image.asset('assets/images/splash.jpg', fit: BoxFit.cover),
          // loading indicator (tetap muncul)
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
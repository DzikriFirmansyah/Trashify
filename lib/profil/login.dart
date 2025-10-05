import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashbin/Main/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();

  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? const Uuid().v4(); // fallback UUID
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? const Uuid().v4();
      } else {
        // untuk web atau platform lain
        return const Uuid().v4();
      }
    } catch (e) {
      debugPrint('Gagal ambil deviceId: $e');
      return const Uuid().v4(); // fallback aman
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg-splash.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Icon(Icons.person, size: 150, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    'SELAMAT DATANG',
                    style: GoogleFonts.righteous(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Masukkan Nama",
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2AFA66),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final name = _nameController.text.trim();
                      if (name.isNotEmpty) {
                        final deviceId =
                            await _getDeviceId(); // ✅ ganti pakai fungsi aman

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('userName', name);
                        await prefs.setString('deviceId', deviceId);

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(deviceId)
                            .set({
                              'userName': name,
                              'deviceId': deviceId,
                              'createdAt': FieldValue.serverTimestamp(),
                            }, SetOptions(merge: true));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 120,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'MASUK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

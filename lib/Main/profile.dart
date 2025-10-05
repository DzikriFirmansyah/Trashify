import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  String? _deviceId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Ambil data dari SharedPreferences + Firestore
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('deviceId');

    if (deviceId == null) {
      setState(() => _isLoading = false);
      return;
    }

    setState(() => _deviceId = deviceId);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(deviceId)
          .get();

      if (snapshot.exists) {
        final userData = snapshot.data();
        _nameController.text = userData?['userName'] ?? '';
      } else {
        _nameController.text = prefs.getString('userName') ?? '';
      }
    } catch (e) {
      debugPrint('⚠️ Gagal ambil data user: $e');
      _nameController.text = prefs.getString('userName') ?? '';
    }

    setState(() => _isLoading = false);
  }

  /// Simpan perubahan ke Firestore dan SharedPreferences
  Future<void> _saveUserName() async {
    if (_deviceId == null) return;

    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    try {
      // 🔹 Update ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_deviceId)
          .update({'userName': newName});

      // 🔹 Simpan juga ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', newName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui!')),
        );
        Navigator.pop(context, newName);
      }
    } catch (e) {
      debugPrint('⚠️ Gagal update nama: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal memperbarui profil')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  // 🔹 Background
                  Image.asset(
                    'assets/images/bg-splash.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),

                  // 🔹 Konten
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.person,
                            size: 150,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 40),

                          // 🔹 Form edit username
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Edit Username",
                              labelStyle: GoogleFonts.poppins(fontSize: 16),
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 🔹 Tombol Simpan
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _saveUserName,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Simpan",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

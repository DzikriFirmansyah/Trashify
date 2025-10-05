import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashbin/Main/scan.dart';
import 'package:trashbin/Main/edukasi.dart';
import 'package:trashbin/main/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _userName;
  String? _deviceId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// 🔹 Ambil data username & deviceId dari SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? "User";
    final deviceId = prefs.getString('deviceId') ?? "Unknown Device";

    setState(() {
      _userName = name;
      _deviceId = deviceId;
    });

    // 🔹 (Opsional) Sinkronisasi ulang data Firestore jika offline sebelumnya
    await _syncUserToFirestore(name, deviceId);
  }

  /// 🔹 Simpan ulang data user ke Firestore (jika belum ada)
  Future<void> _syncUserToFirestore(String name, String deviceId) async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(deviceId);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'userName': name,
        'deviceId': deviceId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Update nama jika berubah
      final data = docSnapshot.data();
      if (data?['userName'] != name) {
        await userDoc.update({'userName': name});
      }
    }
  }

  /// 🔹 Navigasi ke halaman profile dan update username bila berubah
  Future<void> _goToProfilePage() async {
    final updatedName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );

    if (updatedName != null && updatedName is String) {
      setState(() {
        _userName = updatedName;
      });

      // Update juga ke SharedPreferences dan Firestore
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', updatedName);
      if (_deviceId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_deviceId)
            .update({'userName': updatedName});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.book, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EdukasiPage()),
            );
          },
        ),
        title: Text(
          "Dashboard",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black, size: 28),
            onPressed: _goToProfilePage,
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          children: [
            // ✅ Sapaan user
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HELLO,\n${_userName ?? '...'}",
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "📱 Device ID: ${_deviceId ?? '-'}",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Have you checked your trash today?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section Trash Bin
            Text(
              "Trash Bin",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey[800]),

            _buildTrashCard(
              context,
              title: "TRASH BIN 01",
              status: "ON",
              statusColor: Colors.green,
              bgColor: Colors.green[50],
            ),
            _buildTrashCard(
              context,
              title: "TRASH BIN 02",
              status: "OFF",
              statusColor: Colors.grey,
              bgColor: Colors.grey[200],
            ),
            _buildAddTrashCard(context),
          ],
        ),
      ),
    );
  }

  // 🔹 Card untuk Trash Bin
  Widget _buildTrashCard(
    BuildContext context, {
    required String title,
    required String status,
    required Color statusColor,
    required Color? bgColor,
  }) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanPage()),
                );
              },
              child: Image.asset(
                "assets/images/iot-image.jpg",
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Monitor • Gas • Humidity",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, color: statusColor, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Card tambah Trash Bin
  Widget _buildAddTrashCard(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(top: 16, bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tambah Trash Bin diklik")),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline,
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(height: 8),
              Text(
                "Tambah Trash Bin",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

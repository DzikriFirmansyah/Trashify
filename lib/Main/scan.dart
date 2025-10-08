import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trashbin/Main/dashboard.dart';
import 'package:trashbin/Main/edukasi.dart';
import 'package:trashbin/Main/statistic.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  bool isOn = false;
  List<Map<String, dynamic>> sensorHistory = [];

  @override
  void initState() {
    super.initState();
    _listenRealtime();
  }

  void _listenRealtime() {
    // 🔹 Baca status isActive
    _dbRef.child('Control/device_001/isActive').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() => isOn = data == true);
      }
    });

    // 🔹 Baca data sensor (maksimal 10 data terbaru)
    _dbRef.child('Sensors/device_001').onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        final list = data.entries
            .where((e) => e.value is Map) // hanya ambil data yang valid
            .map((e) {
              final val = e.value as Map;
              return {
                "id": e.key,
                "gas": val["gas"],
                "jarak": val["jarak"],
                "kelembapan": val["kelembapan"],
                "timestamp": val["timestamp"],
              };
            })
            .toList();

        // 🔹 Urutkan berdasarkan timestamp (terbaru dulu)
        list.sort((a, b) {
          final tA = DateTime.parse(a["timestamp"]).toLocal();
          final tB = DateTime.parse(b["timestamp"]).toLocal();
          return tB.compareTo(tA); // terbaru dulu
        });

        // 🔹 Ambil hanya 10 data terbaru
        final latest10 = list.take(10).toList();

        setState(() => sensorHistory = latest10);
      }
    });
  }

  void _toggleSwitch(bool value) {
    setState(() => isOn = value);
    _dbRef.child('Control/device_001/isActive').set(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          ),
        ),
        title: Text(
          "Scan",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.book, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EdukasiPage()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _buildControlCard(),
            const SizedBox(height: 20),
            _buildHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar IoT
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/iot-image.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Judul
          Text(
            "Trash Bin Ready!",
            style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 10),

          // Label & Custom Toggle
          Container(
            width: double.infinity,
            height: 35,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final halfWidth = constraints.maxWidth / 2;

                return Stack(
                  children: [
                    // Background geser
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      alignment: isOn
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: halfWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    // Tulisan On / Off
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOn = true;
                                _toggleSwitch(true);
                              });
                            },
                            child: Center(
                              child: Text(
                                "On",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isOn ? Colors.black : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOn = false;
                                _toggleSwitch(false);
                              });
                            },
                            child: Center(
                              child: Text(
                                "Off",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: !isOn ? Colors.black : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "History",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(thickness: 1, color: Colors.grey[800]),
          if (sensorHistory.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "No data yet",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
            )
          else
            ...sensorHistory.map((data) {
              final time = DateTime.parse(data["timestamp"]).toLocal();
              final dateformatted = DateFormat("dd-MM-yyyy").format(time);
              final timeFormatted = DateFormat("HH:mm:ss").format(time);

              return _buildTrashCard(
                context,
                data: data,
                title: dateformatted,
                subtitle:
                    "Gas: ${data['gas']} \nVolume: ${data['jarak']}% \nHumidity: ${data['kelembapan']}%",
                status: timeFormatted,
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildTrashCard(
    BuildContext context, {
    required Map<String, dynamic> data,
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Card(
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: const EdgeInsets.only(top: 12),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StatisticPage(
                volume: double.tryParse(data['jarak']?.toString() ?? '0') ?? 0,
                humidity:
                    double.tryParse(data['kelembapan']?.toString() ?? '0') ?? 0,
                gas: double.tryParse(data['gas']?.toString() ?? '0') ?? 0,
              ),
            ),
          );
        },
        leading: const Icon(Icons.history, color: Colors.green),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 14)),
        subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 12)),
        trailing: Text(
          status,
          style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[700]),
        ),
      ),
    );
  }
}

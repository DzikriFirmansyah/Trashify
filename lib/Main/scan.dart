import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  // State untuk ToggleButtons
  List<bool> isSelected = [true, false]; // default: On aktif
  bool isOn = true; // default ON

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ✅ Navbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()),
            );
          },
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
            icon: const Icon(Icons.book, color: Colors.black, size: 28),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EdukasiPage()),
            );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian hijau atas
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar kecil
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
                      Text(
                        "Trash Bin Ready!",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // ✅ Toggle On/Off
                      Container(
                        width: double.infinity, // ikuti lebar gambar nanti
                        height: 30,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            // Background geser
                            AnimatedAlign(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              alignment: isOn
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                width: (320 - 4) / 2, // separo dari toggle
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),

                            // Tulisan On/Off
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isOn = true;
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "On",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isOn
                                              ? Colors.black
                                              : Colors.black54,
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
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "Off",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: !isOn
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
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
                ),

                const SizedBox(height: 20),

                // Section Trash Bin
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Divider(thickness: 1, color: Colors.grey[800]),

                      // Card 1
                      _buildTrashCard(
                        context,
                        title: DateFormat('EEEE').format(DateTime.now()),
                        subtitle: DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now()), // realtime timestamp,
                        status: DateFormat('HH:mm').format(DateTime.now()),
                      ),

                      // // Card 2
                      // _buildTrashCard(
                      //   context,
                      //   title: DateFormat('dd-MM-yyyy').format(DateTime.now()), // realtime timestamp,
                      //   subtitle: DateFormat('HH:mm').format(DateTime.now()), // realtime timestamp,
                      //   status: "OFF",
                      //   statusColor: Colors.grey,
                      //   bgColor: Colors.grey[200],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrashCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatisticPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
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
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                          Icons.history,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

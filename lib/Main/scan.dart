import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // abu-abu sangat muda
      // ✅ Navbar hijau
      appBar: AppBar(
        backgroundColor: Colors.white, // hijau tua
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {},
        ),
        title: Text(
          "Scan",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // teks putih agar kontras
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.book, color: Colors.black, size: 28),
            onPressed: () {},
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sapaan user
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 20,
                left: 16, // jarak kiri
                right: 16, // jarak kanan
              ),
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 40,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HELLO,\nXXXXXXXX",
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trash Bin",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800], // hijau lebih pekat
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[800], // divider hijau muda
                  ),

                  // Box gambar IoT
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green[100], // background hijau muda
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

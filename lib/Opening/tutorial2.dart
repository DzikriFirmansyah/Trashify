import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tutorial2Page extends StatelessWidget {
  final PageController controller;
  final int pageIndex;
  final int totalPages;

  const Tutorial2Page({
    super.key,
    required this.controller,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Image.asset(
              "assets/images/bg-splash.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            Column(
              children: [
                // Bagian atas (Logo & Skip)
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo kiri atas
                      SizedBox(
                        height: 40,
                        child: Image.asset(
                          "assets/images/Logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Tombol Skip kanan atas
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Gambar di tengah
                Image.asset(
                  'assets/images/content2.png',
                  height: 300,
                  width: 300,
                ),

                const SizedBox(height: 24),

                // Deskripsi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Sampah mudah terbakar berisiko kebakaran. Pisahkan dan buang dengan benar.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(),

                // Dua Tombol: Previous & Next
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Previous
                      if (pageIndex > 0)
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.lightGreen,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Text(
                              "PREVIOUS",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        const Spacer(),

                      const SizedBox(width: 16),

                      // Tombol Next
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.lightGreen,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (pageIndex < totalPages - 1) {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              // kalau halaman terakhir → masuk home
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: Text(
                            pageIndex == totalPages - 1 ? "FINISH" : "NEXT",
                            style: const TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
}

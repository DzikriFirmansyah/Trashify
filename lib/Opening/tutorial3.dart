import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashbin/profil/login.dart';

class Tutorial3Page extends StatelessWidget {
  final PageController controller;
  final int pageIndex;
  final int totalPages;

  const Tutorial3Page({
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
                    ],
                  ),
                ),

                const Spacer(),

                // Gambar di tengah
                Image.asset(
                  'assets/images/content3.png',
                  height: 300,
                  width: 300,
                ),

                const SizedBox(height: 24),

                // Deskripsi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Sampah lembap menimbulkan bau dan serangga. Buang rutin agar lingkungan nyaman.",
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
                              foregroundColor: Colors.green,
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
                                color: Colors.green,
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
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.green,
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
                              // kalau sudah di halaman terakhir → masuk ke LoginPage
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0); // mulai dari kanan
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Text(
                            pageIndex == totalPages - 1
                                ? "GET STARTED"
                                : "NEXT",
                            style: const TextStyle(
                              color: Colors.white,
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

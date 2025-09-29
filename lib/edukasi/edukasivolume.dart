import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashbin/Main/dashboard.dart';
import 'package:trashbin/Main/scan.dart';
import 'package:trashbin/edukasi/edukasigas.dart';
import 'package:trashbin/edukasi/edukasikelembapan.dart';


class EdukasiVolume extends StatefulWidget {
  const EdukasiVolume({super.key});

  @override
  State<EdukasiVolume> createState() => _EdukasiVolumeState();
}

class _EdukasiVolumeState extends State<EdukasiVolume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.pop(context); // balik ke halaman sebelumnya
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
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white, // ✅ body jadi putih
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 40, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EdukasiVolume(),
                          ));
                    },
                    child: Text(
                      'Volume',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EdukasiKelembapan(),
                          ));
                    },
                    child: Text(
                      'Kelembapan',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EdukasiGas(),
                          ));
                    },
                    child: Text(
                      'Gas',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          )),
          SliverToBoxAdapter(
              child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 110,
                              height: 20,
                              child: Text(
                                'Sangat Rendah',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(70, 222, 255, 100),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              width: 400,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 20),
                                child: Text(
                                  'Volume sampah hampir kosong sehingga tidak memerlukan tindakan khusus, cukup teruskan monitoring rutin.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 25,
                              child: Text(
                                'Rendah',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 133, 255, 100),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              width: 400,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 20),
                                child: Text(
                                  'Tempat sampah mulai terisi sedikit dan masih aman, cukup dipantau secara berkala agar tidak menumpuk.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 65,
                              height: 25,
                              child: Text(
                                'Stabil',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(66, 255, 0, 100),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              width: 400,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 20),
                                child: Text(
                                  'Kondisi tempat sampah sudah setengah penuh sehingga perlu mulai dijadwalkan pengangkutan sebelum penuh.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 65,
                              height: 25,
                              child: Text(
                                'Tinggi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 92, 0, 100),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              width: 400,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 20),
                                child: Text(
                                  'Volume sampah mendekati kapasitas maksimum sehingga harus segera dijadwalkan pengosongan atau pengangkutan.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 25,
                              child: Text(
                                'Sangat Tinggi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 0, 0, 100),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Container(
                              width: 400,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 20),
                                child: Text(
                                  'Tempat sampah sudah penuh dan berisiko meluap, segera lakukan pengangkutan atau pembersihan untuk mencegah pencemaran.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 230, 230),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
          ),
        ],
      ),
    );
  }
}

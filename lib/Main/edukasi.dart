import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashbin/Main/dashboard.dart';

class EdukasiPage extends StatefulWidget {
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Data untuk tiap tab
  final List<List<Map<String, dynamic>>> contents = [
    // Volume
    [
      {
        "label": "Sangat Rendah",
        "color": Color(0xFF46DEFF),
        "desc":
            "Volume sampah hampir kosong sehingga tidak memerlukan tindakan khusus, cukup teruskan monitoring rutin."
      },
      {
        "label": "Rendah",
        "color": Color(0xFF0085FF),
        "desc":
            "Tempat sampah mulai terisi sedikit dan masih aman, cukup dipantau secara berkala agar tidak menumpuk."
      },
      {
        "label": "Stabil",
        "color": Color(0xFF42FF00),
        "desc":
            "Kondisi tempat sampah sudah setengah penuh sehingga perlu mulai dijadwalkan pengangkutan sebelum penuh."
      },
      {
        "label": "Tinggi",
        "color": Color(0xFFFF5C00),
        "desc":
            "Volume sampah mendekati kapasitas maksimum sehingga harus segera dijadwalkan pengosongan atau pengangkutan."
      },
      {
        "label": "Sangat Tinggi",
        "color": Color(0xFFFF0000),
        "desc":
            "Tempat sampah sudah penuh dan berisiko meluap, segera lakukan pengangkutan atau pembersihan untuk mencegah pencemaran."
      },
    ],

    // Kelembapan
    [
      {
        "label": "Sangat Kering",
        "color": Color(0xFF46DEFF),
        "desc":
            "Kondisi sampah sangat kering, risiko pembusukan rendah, cukup dipantau."
      },
      {
        "label": "Kering",
        "color": Color(0xFF0085FF),
        "desc":
            "Kelembapan rendah, masih aman dan tidak menimbulkan bau menyengat."
      },
      {
        "label": "Normal",
        "color": Color(0xFF42FF00),
        "desc":
            "Kelembapan stabil, kondisi sampah masih dalam batas wajar dan aman."
      },
      {
        "label": "Lembap",
        "color": Color(0xFFFF5C00),
        "desc":
            "Kelembapan mulai tinggi, perlu perhatian agar tidak menimbulkan bau dan menarik serangga."
      },
      {
        "label": "Sangat Lembap",
        "color": Color(0xFFFF0000),
        "desc":
            "Kondisi sangat lembap, risiko pembusukan dan bau tinggi, segera lakukan pengelolaan."
      },
    ],

    // Gas
    [
      {
        "label": "Sangat Rendah",
        "color": Color(0xFF46DEFF),
        "desc":
            "Kadar gas sangat rendah, kondisi aman dan tidak berbahaya."
      },
      {
        "label": "Rendah",
        "color": Color(0xFF0085FF),
        "desc":
            "Gas mulai terdeteksi, namun masih dalam batas aman untuk lingkungan."
      },
      {
        "label": "Stabil",
        "color": Color(0xFF42FF00),
        "desc":
            "Kadar gas normal, tidak menimbulkan risiko berarti bagi lingkungan."
      },
      {
        "label": "Tinggi",
        "color": Color(0xFFFF5C00),
        "desc":
            "Gas mendekati ambang batas, perlu segera dipantau agar tidak membahayakan."
      },
      {
        "label": "Sangat Tinggi",
        "color": Color(0xFFFF0000),
        "desc":
            "Gas berbahaya, segera lakukan pengelolaan untuk mencegah pencemaran udara."
      },
    ],
  ];

  Widget buildLevelCard(String label, Color color, String desc) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              desc,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabButton(String text, int index) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
        ),
        title: Text(
          "Edukasi",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.book, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Tab Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTabButton("Volume", 0),
              buildTabButton("Kelembapan", 1),
              buildTabButton("Gas", 2),
            ],
          ),
          const SizedBox(height: 20),

          // Content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemCount: contents.length,
              itemBuilder: (context, tabIndex) {
                final list = contents[tabIndex];
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: list
                      .map((item) => buildLevelCard(
                            item["label"],
                            item["color"],
                            item["desc"],
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

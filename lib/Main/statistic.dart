import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trashbin/Main/edukasi.dart';
import 'package:trashbin/Main/scan.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Nilai contoh (bisa nanti diganti dari sensor/API)
    final double volume = 60; // %
    final double humidity = 40; // %
    final double gas = 2500; // ppm
    final double gasPercent = double.parse(
      ((gas / 15000) * 100).toStringAsFixed(1),
    );

    // ✅ Data Chart dengan warna sesuai _getColor
    final List<_ChartData> chartData = [
      _ChartData('Gas', gasPercent, _getColor(gasPercent)),
      _ChartData('Humidity', humidity, _getColor(humidity)),
      _ChartData('Volume', volume, _getColor(volume)),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanPage()),
            );
          },
        ),
        title: Text(
          "Statistic",
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ✅ Radial Bar Chart
            Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: SfCircularChart(
                series: <RadialBarSeries<_ChartData, String>>[
                  RadialBarSeries<_ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (_ChartData data, _) => data.label,
                    yValueMapper: (_ChartData data, _) => data.value,
                    pointColorMapper: (_ChartData data, _) => data.color,
                    radius: '100%',
                    innerRadius: '30%',
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ✅ Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Status",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ✅ Detail Card Statistik
            _buildStatCard("Volume", volume, 100), // %
            _buildStatCard("Kelembapan", humidity, 100), // %
            _buildStatCard("Gas", gas, 15000), // ppm
          ],
        ),
      ),
    );
  }

  // Card Statistik
  Widget _buildStatCard(String title, double value, double maxValue) {
    // ✅ hitung persentase
    double percent = (value / maxValue) * 100;
    percent = percent.clamp(0, 100); // pastikan aman

    return Card(
      elevation: 3,
      color: Colors.grey[100],
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul sensor
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Progress Bar
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Bagian terisi
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percent / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getColor(percent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  // Persentase di tengah
                  Center(
                    child: Text(
                      "${percent.toStringAsFixed(1)}%",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
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

  // Fungsi warna dinamis
  static Color _getColor(double percent) {
    if (percent <= 20) {
      return Colors.lightBlueAccent;
    } else if (percent <= 40) {
      return Colors.blue;
    } else if (percent <= 60) {
      return Colors.green;
    } else if (percent <= 80) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

// ✅ Data model untuk chart
class _ChartData {
  final String label;
  final double value;
  final Color color;
  _ChartData(this.label, this.value, this.color);
}

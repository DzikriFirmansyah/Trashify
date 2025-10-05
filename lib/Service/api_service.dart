import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();

class ApiService {
  static const String _baseUrl = "http://192.168.1.10:5000/api/Statistic";

  static Future<bool> insertUsername(String deviceId, String userName) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/input-username"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'deviceId': deviceId, 'userName': userName}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        logger.w('Gagal kirim data: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      logger.e('Error insertUsername: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getLatestStatistic(
    String deviceId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/get-latest?deviceId=$deviceId"),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        logger.w('Gagal ambil data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      logger.e('Error getLatestStatistic: $e');
      return null;
    }
  }
}

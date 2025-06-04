import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainingModalViewModel {
  static Future<bool> submitTraining({
    required int userId,
    required int charId,
    required Map<String, int> updatedStats,
    required int usePoint,
  }) async {
    final uri = Uri.parse('http://localhost:8000/update/update_char_status');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'char_id': charId,
        'use_point': usePoint,
        'hp': updatedStats['HP'],
        'atk': updatedStats['ATK'],
        'defense': updatedStats['DEF'],
        'spe': updatedStats['AGI'],
        'luc': updatedStats['LUK'],
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> submitPointLog({
    required int userId,
    required String pointInfo,
    required int usePoint,
  }) async {
    final uri = Uri.parse('http://localhost:8000/update/update_point');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'point_info': pointInfo,
        'use_point': usePoint,
      }),
    );

    return response.statusCode == 200;
  }
}

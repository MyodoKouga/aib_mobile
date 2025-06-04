import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/model/character_model.dart';
import 'package:http/http.dart' as http;


Future<bool> deleteCharacter({required int userId, required int charId}) async {
  final uri = Uri.parse('http://localhost:8000/delete/char_delete');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId,
      'char_id': charId,
    }),
  );

  final data = jsonDecode(response.body);

  return response.statusCode == 200 && data['status'] == 'success';
}

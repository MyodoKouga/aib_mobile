import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/model/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:app/features/home/model/character_detail_model.dart';

Future<CharacterDetail?> fetchCharacterDetail ({
  required int userId,
  required int charId,
  required String name,
  Uint8List? image,
}) async {
  final uri = Uri.parse('http://localhost:8000/get/char_info');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId,
      'char_id': charId,
    }),
  );

  final body = jsonDecode(response.body);

  if (response.statusCode == 200 && body['status'] == 'success') {
    return CharacterDetail.fromJson({
      ...body, // ← APIのデータ
      'char_id': charId,
      'char_name': name,
      'image_path': null, // ← image_pathが無い場合の保険
    }, image: image); // ← 後から代入（プロパティが final じゃない場合）
  } else {
    print('🚨 API失敗: ${body['message']}');
    return null;
  }
}

Future<bool> updateMainCharacter({required int userId, required int charId}) async {
  final uri = Uri.parse('http://localhost:8000/update/update_my_char');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId,
      'char_id': charId,
    }),
  );

  final body = jsonDecode(response.body);
  return response.statusCode == 200 && body['status'] == 'success';
}

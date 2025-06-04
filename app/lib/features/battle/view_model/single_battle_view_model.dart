import 'dart:convert';
import 'package:http/http.dart' as http;

/// バトル実行API → 成功時は詳細データを返す
Future<Map<String, dynamic>?> startSingleBattle({
  required int userId,
  required int charId,
}) async {
  final uri = Uri.parse('http://localhost:8000/battle/pattern1');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'user_id': userId, 'char_id': charId}),
  );

  if (response.statusCode != 200) return null;

  final body = jsonDecode(response.body);
  if (body['status'] == 'success') {
    return body; // battle_summary と battle_result を含む
  } else {
    return null;
  }
}

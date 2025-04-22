import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:app/features/create/model/create_char_model.dart';

final createCharViewModelProvider = StateNotifierProvider<CreateCharViewModel, void>((ref) {
  return CreateCharViewModel();
});

class CreateCharViewModel extends StateNotifier<void> {
  CreateCharViewModel() : super(null);

  Future<bool> submitCharacter(Character character) async {
    final url = Uri.parse('http://localhost:8000/create/patternP1');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(character.toJson()),
      );
      print(json.encode(character.toJson()));

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception('サーバーエラー: ${errorResponse['detail'] ?? response.statusCode}');
      }
    } catch (e) {
      throw Exception('サーバー通信に失敗しました: \$e');
    }
  }
}

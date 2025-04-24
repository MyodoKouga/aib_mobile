import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/model/character_model.dart';
import 'package:http/http.dart' as http;

final characterListProvider = AsyncNotifierProvider<CharacterListViewModel, List<Character>>(
  () => CharacterListViewModel(),
);

class CharacterListViewModel extends AsyncNotifier<List<Character>> {
  @override
  Future<List<Character>> build() async {
    return await _fetchCharacters();
  }

  Future<List<Character>> _fetchCharacters() async {
    try {
      final url = Uri.parse('http://localhost:8000/get/char_list');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': 1}),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> characterJsonList = data['characters'];

      return characterJsonList.map((json) => Character.fromJson(json)).toList();
    } catch (e) {
      print('キャラ一覧の取得失敗: $e');
      rethrow;
    }
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _fetchCharacters());
  }
}

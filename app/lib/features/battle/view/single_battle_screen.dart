import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/battle/view/character_change_screen.dart';
import 'package:app/features/battle/view/battle_result_screen.dart';

class SingleBattleScreen extends ConsumerWidget {
  final int pattern;

  SingleBattleScreen({super.key, required this.pattern});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charImageState = ref.watch(charDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('シングルバトル'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Center(
                  child: charImageState.when(
                    data: (imageData) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.memory(
                          imageData,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),

                        // キャラクター名
                        const Text(
                          'キャラクター名: テストキャラ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        // 必殺技
                        const Text(
                          '必殺技: ファイナルストライク',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (err, _) => const Text(
                      '画像の取得に失敗しました',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CharacterChangeScreen(),
                        ),
                      );
                    },
                    child: const Text('変更'),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 48.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BattleResultScreen(),
                    ),
                  );
                },
                child: const Text('対戦する'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// サーバ通信用のプロバイダ
final charDataProvider = FutureProvider<Uint8List>((ref) async {
  try {
    final userId = 1;
    final mainCharId = 1;

    final url = Uri.parse('http://localhost:8000/get/char_image');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'char_id': mainCharId}),
    );

    if (response.statusCode != 200) {
      throw Exception('サーバエラー: ${response.statusCode}');
    }

    return response.bodyBytes;
  } catch (e) {
    debugPrint('Error fetching image: $e');
    throw Exception('画像の取得に失敗しました');
  }
});

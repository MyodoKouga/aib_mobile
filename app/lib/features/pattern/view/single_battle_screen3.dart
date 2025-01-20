import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/features/pattern/view/battle_result_screen.dart';

class SingleBattleScreen3 extends StatelessWidget {
  final int pattern;

  SingleBattleScreen3({super.key, required this.pattern});

  // TextEditingControllerを定義
  final TextEditingController _characterNameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _attackSkillController = TextEditingController();
  final TextEditingController _defenseSkillController = TextEditingController();
  final TextEditingController _specialMoveController = TextEditingController();

  Future<Map<String, dynamic>> _fetchBattleResult({
    required int pattern,
    required String characterName,
    required int hp,
    required String attackSkill,
    required String defenseSkill,
    required String specialMove,
  }) async {
    final url = Uri.parse('http://localhost:8000/battle/pattern3');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'pattern': pattern,
          'character_name': characterName,
          'hp': hp,
          'attack_skill': attackSkill,
          'defense_skill': defenseSkill,
          'special_move': specialMove,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        return responseData;
      } else {
        final errorResponse = json.decode(response.body);
        throw Exception('サーバーエラー: ${errorResponse['detail'] ?? response.statusCode}');
      }
    } catch (e) {
      throw Exception('サーバー通信に失敗しました: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'キャラクター設定',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _characterNameController,
                    decoration: const InputDecoration(
                      labelText: 'キャラクター名',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _hpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'HP',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _attackSkillController,
                    decoration: const InputDecoration(
                      labelText: '攻撃スキル',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _defenseSkillController,
                    decoration: const InputDecoration(
                      labelText: '防御スキル',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _specialMoveController,
                    decoration: const InputDecoration(
                      labelText: '必殺技',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
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
                onPressed: () async {
                  try {
                    // 入力値を取得
                    final characterName = _characterNameController.text;
                    final hp = int.tryParse(_hpController.text) ?? 0;
                    final attackSkill = _attackSkillController.text;
                    final defenseSkill = _defenseSkillController.text;
                    final specialMove = _specialMoveController.text;

                    // API呼び出し
                    final result = await _fetchBattleResult(
                      pattern: pattern,
                      characterName: characterName,
                      hp: hp,
                      attackSkill: attackSkill,
                      defenseSkill: defenseSkill,
                      specialMove: specialMove,
                    );

                    // 結果画面に遷移
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BattleResultScreen(result: result),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('エラーが発生しました: $e')),
                    );
                  }
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

//battle_result_screen.dart

import 'package:flutter/material.dart';

class BattleResultScreen extends StatelessWidget {
  final String battleResult; // "勝ち" など
  final String battleSummary; // 詳細ログ

  const BattleResultScreen({
    Key? key,
    required this.battleResult,
    required this.battleSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isVictory = battleResult.contains('勝');
    final String resultText = isVictory ? '勝利' : '敗北';
    final Color resultColor = isVictory ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('対戦結果'),
      ),
      body: Column(
        children: [
          // 勝敗カード
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: resultColor.withOpacity(0.1),
              border: Border.all(color: resultColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                resultText,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ),
          ),

          // バトル詳細表示
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    battleSummary,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // 戻るボタン
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('選択画面に戻る'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

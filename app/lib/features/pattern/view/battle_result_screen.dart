import 'package:flutter/material.dart';

class BattleResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;
  const BattleResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // 対戦結果の詳細を取得
    final String battleSummary = result['battle_summary'] ?? '詳細が取得できませんでした。';
    final String battleResult = result['battle_result'] ?? '結果不明';

    // 勝利か敗北の判定
    final bool isVictory = battleResult.contains('勝ち');
    final String resultText = battleResult.contains('勝ち')
      ? '勝利'
      : battleResult.contains('負け')
          ? '敗北'
          : '不明';
    final Color resultColor = isVictory ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('対戦結果'),
      ),
      body: Column(
        children: [
          // 勝敗表示のカード
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

          // 対戦の詳細表示
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

          // ボタン
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('選択画面に戻る'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

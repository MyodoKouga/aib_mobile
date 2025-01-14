import 'dart:math';
import 'package:flutter/material.dart';

class BattleResultScreen extends StatelessWidget {
  const BattleResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isVictory = Random().nextBool();
    final String resultText = isVictory ? '勝利' : '敗北';
    final Color resultColor = isVictory ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('対戦結果'),
      ),
      body: Column(
        children: [
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
                  child: const Text(
                    'ここに対戦の詳細が表示されます。\n\n'
                    '対戦の結果や使用されたキャラクターのステータス、ダメージの履歴などの情報を表示します。\n\n'
                    'このテキストエリアはスクロール可能です。',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

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

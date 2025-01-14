import 'package:flutter/material.dart';
import 'package:app/features/battle/view/character_change_screen.dart';
import 'package:app/features/battle/view/battle_result_screen.dart';

class SingleBattleScreen extends StatelessWidget {
  const SingleBattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('シングルバトル'),
      ),
      body: Column(
        children: [
          // キャラクター画像枠
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    'AIキャラクター画像/ステータス',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      // キャラクター変更ページに遷移
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

import 'package:flutter/material.dart';
import 'package:app/features/battle/view/single_battle_screen.dart';
import 'package:app/features/battle/view/tournament_screen.dart';

class BattleTab extends StatelessWidget {
  const BattleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SingleBattleScreen(),
                  ),
                );
              },
              child: const Text('シングルバトル'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TournamentScreen(),
                  ),
                );
              },
              child: const Text('トーナメント'),
            ),
          ],
        ),
      ),
    );
  }
}

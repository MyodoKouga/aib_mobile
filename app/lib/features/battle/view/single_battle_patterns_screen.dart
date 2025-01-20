import 'package:flutter/material.dart';
import 'single_battle_screen.dart';
import 'package:app/features/pattern/view/single_battle_screen1.dart';
import 'package:app/features/pattern/view/single_battle_screen2.dart';
import 'package:app/features/pattern/view/single_battle_screen3.dart';
import 'package:app/features/pattern/view/single_battle_screen4.dart';
import 'package:app/features/pattern/view/single_battle_screen5.dart';

class SingleBattlePatternsScreen extends StatelessWidget {
  const SingleBattlePatternsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('シングルバトルパターン'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Widget destinationScreen;
                  switch (index + 1) {
                    case 1:
                      destinationScreen = SingleBattleScreen1(pattern: index + 1);
                      break;
                    case 2:
                      destinationScreen = SingleBattleScreen2(pattern: index + 1);
                      break;
                    case 3:
                      destinationScreen = SingleBattleScreen3(pattern: index + 1);
                      break;
                    case 4:
                      destinationScreen = SingleBattleScreen4(pattern: index + 1);
                      break;
                    case 5:
                      destinationScreen = SingleBattleScreen5(pattern: index + 1);
                      break;
                    default:
                      destinationScreen = SingleBattleScreen(pattern: index + 1);
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => destinationScreen,
                    ),
                  );
                },
                child: Text('パターン ${index + 1}'),
              ),
            );
          },
        ),
      ),
    );
  }
}

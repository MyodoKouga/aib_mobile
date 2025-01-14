import 'package:flutter/material.dart';
import 'single_battle_screen.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleBattleScreen(pattern: index + 1),
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

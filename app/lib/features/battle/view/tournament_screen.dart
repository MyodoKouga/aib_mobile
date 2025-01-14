import 'package:flutter/material.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('トーナメント'),
      ),
      body: const Center(
        child: Text('トーナメント画面'),
      ),
    );
  }
}

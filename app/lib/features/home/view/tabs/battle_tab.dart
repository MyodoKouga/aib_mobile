import 'package:flutter/material.dart';
import 'package:app/features/battle/view/tournament_screen.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/features/battle/view/single_battle_screen.dart';

class BattleTab extends StatelessWidget {
  const BattleTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenHeight * 0.8;
    final containerWidth = screenWidth * 0.9;
    final cardSpacing = containerHeight * 0.05;
    final buttonFontSize = screenHeight * 0.03;
    final iconSize = screenHeight * 0.1;

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: Center(
        child: SizedBox(
          height: containerHeight,
          width: containerWidth,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // シングルバトルカード
                Expanded(
                  child: NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleBattleScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_mma,
                            size: iconSize,
                            color: Colors.black87,
                          ),
                          SizedBox(height: containerHeight * 0.02),
                          Text(
                            'シングルバトル',
                            style: TextStyle(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: cardSpacing),
                // トーナメントカード
                Expanded(
                  child: NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TournamentScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: iconSize,
                            color: Colors.black87,
                          ),
                          SizedBox(height: containerHeight * 0.02),
                          Text(
                            'トーナメント',
                            style: TextStyle(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

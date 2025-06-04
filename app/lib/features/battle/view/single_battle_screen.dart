// single_battle_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/home/model/character_detail_model.dart';
import 'package:app/features/battle/view/single_battle_character_select_screen.dart';
import 'package:app/features/battle/view/battle_result_screen.dart';
import 'package:app/features/battle/view_model/single_battle_view_model.dart' as battle;

class SingleBattleScreen extends StatefulWidget {
  const SingleBattleScreen({Key? key}) : super(key: key);

  @override
  State<SingleBattleScreen> createState() => _SingleBattleScreenState();
}

class _SingleBattleScreenState extends State<SingleBattleScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonHeight = screenHeight * 0.07;

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      appBar: AppBar(
        title: const Text('シングルバトル'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer(builder: (context, ref, _) {
        final homeState = ref.watch(homeViewModelProvider);

        return Column(
          children: [
            _buildMainContent(context, ref),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: NeumorphicButton(
onPressed: () async {
  // ログを追加して状態を確認
  debugPrint('[DEBUG] ボタン押下前: _isLoading=$_isLoading, myCharId=${homeState.myCharId}');

  if (_isLoading || homeState.myCharId == null) {
    debugPrint('[WARN] ボタンが無効な状態で押されました');
    return;
  }

  debugPrint('[DEBUG] onPressedが呼ばれました');
  setState(() => _isLoading = true);

  final userId = ref.read(homeViewModelProvider).userId;
  if (userId == null) {
    debugPrint('[ERROR] userId is null');
    setState(() => _isLoading = false);
    return;
  }
  final charId = int.tryParse(homeState.myCharId!);

  debugPrint('[DEBUG] バトル開始ボタン: userId=$userId, charId=${homeState.myCharId}');

  if (charId == null || charId == 0) {
    debugPrint('[ERROR] charIdの値が不正です。');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('キャラIDが無効です')),
    );
    setState(() => _isLoading = false);
    return;
  }

  try {
    final result = await battle.startSingleBattle(
      userId: userId,
      charId: charId,
    );

    debugPrint('[DEBUG] startSingleBattleの結果: $result');

    if (!mounted) return;

    if (result != null) {
      final summary = result['battle_summary'] ?? 'バトル詳細不明';
      final resultText = result['battle_result'] ?? '結果不明';

      debugPrint('[DEBUG] BattleResultScreenに遷移: $resultText');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BattleResultScreen(
            battleResult: resultText,
            battleSummary: summary,
          ),
        ),
      );
    } else {
      debugPrint('[ERROR] バトルAPI呼び出しに失敗しました');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('バトル開始に失敗しました')),
      );
    }
  } catch (e) {
    debugPrint('[EXCEPTION] $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('エラーが発生しました: $e')),
    );
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
},
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'バトル開始！！！',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: NeumorphicButton(
                      onPressed: () async {
                        final selected = await Navigator.of(context).push<CharacterDetail>(
                          MaterialPageRoute(builder: (_) => const SingleBattleCharacterSelectScreen()),
                        );
                        if (selected != null) {
                          debugPrint('[DEBUG] キャラクター変更後にsetState');
                          setState(() {});
                        }
                      },
                      child: const Center(
                        child: Text(
                          'キャラクター変更',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMainContent(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenHeight * 0.02;
    final containerHeight = screenHeight * 0.47;
    final containerWidth = screenWidth * 0.85;
    final imageSize = screenHeight * 0.3;
    final fontSize = screenHeight * 0.025;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        height: containerHeight,
        width: containerWidth,
        child: NeumorphicContainer(
          radius: 20,
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'バトルキャラクター',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: padding),
              homeState.isLoading
                  ? const CircularProgressIndicator()
                  : homeState.characterImage != null
                      ? Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                homeState.characterImage!,
                                width: imageSize,
                                height: imageSize,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: padding),
                            Text(
                              homeState.characterName ?? '',
                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : const Text(
                          '画像の取得に失敗しました',
                          style: TextStyle(color: Colors.red),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

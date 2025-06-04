import 'dart:typed_data';
import 'package:app/features/home/model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/home/view_model/list_view_model.dart';
import 'package:app/features/home/model/character_detail_model.dart';
import 'package:app/features/home/view_model/character_delete_view_model.dart';
import 'package:app/features/home/view_model/character_detail_view_model.dart';
import 'package:app/features/home/view/widget/training_modal.dart';

class CharacterDetailScreen extends ConsumerStatefulWidget {
  final CharacterDetail character;
  const CharacterDetailScreen({Key? key, required this.character}) : super(key: key);

  @override
  ConsumerState<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {
  late CharacterDetail character;

  @override
  void initState() {
    super.initState();
    character = widget.character;
  }

  void _openTrainingModal(BuildContext context) async {
    final points = ref.read(homeViewModelProvider).points;

    final updatedStats = await showDialog<Map<String, int>>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.zero,
        content: TrainingModal(
          initialStats: {
            'HP': character.hp,
            'ATK': character.atk,
            'DEF': character.def,
            'AGI': character.agi,
            'LUK': character.luk,
          },
          totalPoints: points,
          charId: character.id,
          totalUsePoint: character.totalUsePoint,
        ),
      ),
    );

    if (updatedStats != null) {
      final updated = await fetchCharacterDetail(
        userId: ref.read(homeViewModelProvider).userId!,
        charId: character.id,
        name: character.name,
        image: character.image,
      );

      if (updated != null && mounted) {
        setState(() {
          character = updated;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('キャラクター詳細'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: NeumorphicContainer(
                radius: 16,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (character.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          character.image!,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(character.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text('HP: ${character.hp}   ATK: ${character.atk}   DEF: ${character.def}   AGI: ${character.agi}   LUK: ${character.luk}'),
                    const SizedBox(height: 16),
                    Text('攻撃スキル: ${character.attackSkill}', style: const TextStyle(fontSize: 18)),
                    Text('防御スキル: ${character.defenseSkill}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    Text('必殺技: ${character.specialMove}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(character.specialDetail, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: NeumorphicContainer(
                    radius: 24,
                    padding: EdgeInsets.zero,
                    child: IconButton(
                      onPressed: () async {
                        final userId = ref.read(homeViewModelProvider).userId;
                        if (userId == null) return;
                        final success = await updateMainCharacter(userId: userId, charId: character.id);
                        if (success && mounted) {
                          setState(() => character.isMainChar = 1);
                          ref.invalidate(homeViewModelProvider);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('メインキャラクターを更新しました')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('更新に失敗しました')),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.star,
                        color: character.isMainChar == 0 ? Colors.grey : Colors.blue,
                      ),
                      iconSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: NeumorphicButton(
                    onPressed: () => _openTrainingModal(context),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text('キャラクターを強化', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: NeumorphicContainer(
                    radius: 24,
                    padding: EdgeInsets.zero,
                    child: IconButton(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('削除の確認'),
                            content: const Text('このキャラクターを本当に削除しますか？'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('キャンセル')),
                              TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('削除')),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final userId = ref.read(homeViewModelProvider).userId;
                          if (userId == null) return;
                          final success = await deleteCharacter(userId: userId, charId: character.id);
                          if (success && context.mounted) {
                            ref.invalidate(characterListProvider);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('キャラクターを削除しました')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('削除に失敗しました')));
                          }
                        }
                      },
                      icon: const Icon(Icons.delete_forever, color: Colors.red),
                      iconSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

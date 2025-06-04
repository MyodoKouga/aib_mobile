import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/features/home/view_model/list_view_model.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/home/view_model/character_detail_view_model.dart';

class SingleBattleCharacterSelectScreen extends ConsumerWidget {
  const SingleBattleCharacterSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterListState = ref.watch(characterListProvider);

    if (characterListState.value == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFE0E5EC),
        body: Center(child: Text('キャラクターが取得できませんでした')),
      );
    }

    final characters = characterListState.value!;
    const int userId = 1; // TODO: 後で実際のユーザーIDに差し替える

    return Scaffold(
      appBar: AppBar(
        title: const Text('キャラクターを選択'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFE0E5EC),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () async {
                // 1. メインキャラとして更新
                final success = await updateMainCharacter(
                  userId: userId,
                  charId: character.id,
                );

                if (!success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('メインキャラクターの更新に失敗しました')),
                  );
                  return;
                }

                // 2. 詳細データ取得
                final detail = await fetchCharacterDetail(
                  userId: userId,
                  charId: character.id,
                  name: character.name,
                  image: character.image,
                );

                if (detail != null && context.mounted) {
                  ref.invalidate(homeViewModelProvider);
                  Navigator.of(context).pop(detail);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('メインキャラクターを更新しました')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('キャラクター詳細の取得に失敗しました')),
                  );
                }
              },
              child: NeumorphicContainer(
                radius: 16,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (character.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          character.image!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        character.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

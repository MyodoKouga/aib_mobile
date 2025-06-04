import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/view/tabs/character_detail_screen.dart';
import 'package:app/features/home/view_model/list_view_model.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/features/home/view_model/character_detail_view_model.dart';

class ListTab extends ConsumerWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(characterListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('キャラクター一覧'),
      ),
      backgroundColor: const Color(0xFFE0E5EC),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラーが発生しました: $err')),
        data: (characterList) {
          final isLimitReached = characterList.length >= 30;

          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'マイキャラクター　${characterList.length}/30',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: characterList.isEmpty
                          ? const Center(child: Text('キャラクターが存在しません'))
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 3 / 4,
                              ),
                              itemCount: characterList.length,
                              itemBuilder: (context, index) {
                                final char = characterList[index];

                                return InkWell(
                                  onTap: () async {
                                    // final userId = ref.read(homeViewModelProvider).userId; // ユーザーIDの取得（Riverpod）
                                    final userId = 1;//テスト用
                                    final detail = await fetchCharacterDetail(
                                      userId: userId,
                                      charId: char.id,
                                      name: char.name,
                                      image: char.image,
                                    );

                                    if (detail != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CharacterDetailScreen(character: detail),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('キャラクター詳細の取得に失敗しました')),
                                      );
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: NeumorphicContainer(
                                    radius: 12,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: char.image != null
                                                ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Image.memory(
                                                      char.image!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    ),
                                                  )
                                                : const Center(
                                                    child: Text(
                                                      '画像なし',
                                                      style: TextStyle(color: Colors.grey),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            char.name,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 26.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: NeumorphicButton(
                        onPressed: isLimitReached
                            ? null
                            : () => ref.read(homeViewModelProvider.notifier).handleCreateButtonPress(context),
                        child: Text(
                          isLimitReached ? 'キャラ上限です' : 'AIキャラクター新規作成',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

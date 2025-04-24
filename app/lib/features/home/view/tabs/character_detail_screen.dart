import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/features/home/view_model/home_view_model.dart';

class CharacterDetailScreen extends ConsumerWidget {
  final String name;
  final Uint8List? image;

  const CharacterDetailScreen({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  void _openTrainingModal(BuildContext context, WidgetRef ref) async {
    final points = ref.read(homeViewModelProvider).points;

    final updatedStats = await showDialog<Map<String, int>>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(0),
        content: TrainingModal(
          initialStats: {
            'HP': 10,
            'ATK': 12,
            'DEF': 8,
            'AGI': 15,
            'LUK': 5,
          },
          totalPoints: points,
        ),
      ),
    );

    if (updatedStats != null) {
      print('更新されたステータス: $updatedStats');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    if (image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          image!,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text('HP: 10   ATK: 12   DEF: 8   AGI: 15   LUK: 5', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    const Text('攻撃スキル: パンチ', style: TextStyle(fontSize: 18)),
                    const Text('防御スキル: ガード', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    const Text('必殺技: ラグナロク', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text(
                      '世界は終末を迎え全ては死に絶える',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
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
                      onPressed: () {},
                      icon: const Icon(Icons.star, color: Colors.blue),
                      iconSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: NeumorphicButton(
                    onPressed: () => _openTrainingModal(context, ref),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'キャラクターを強化',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('キャンセル'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('削除'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          // TODO: キャラクター削除処理をここに入れる
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('キャラクターを削除しました')),
                          );
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

class TrainingModal extends StatefulWidget {
  final Map<String, int> initialStats;
  final int totalPoints;

  const TrainingModal({super.key, required this.initialStats, required this.totalPoints});

  @override
  State<TrainingModal> createState() => _TrainingModalState();
}

class _TrainingModalState extends State<TrainingModal> {
  late Map<String, int> status;
  late Map<String, int> base;
  int get usedPoint => status.entries.map((e) => e.value - base[e.key]!).fold(0, (a, b) => a + b);
  int get userTotalPoint => widget.totalPoints;
  int get enhancePoint => usedPoint;
  int get remainingPoint => userTotalPoint - (enhancePoint * 100);

  @override
  void initState() {
    super.initState();
    status = Map<String, int>.from(widget.initialStats);
    base = Map<String, int>.from(widget.initialStats);
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      radius: 20,
      padding: const EdgeInsets.all(38),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ステータス強化', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Text('所持ポイント: $remainingPoint p', style: const TextStyle(fontSize: 24)),
          Text('(100 p = 能力強化１)', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          Text('強化合計: $enhancePoint / 50', style: const TextStyle(fontSize: 18)),
          ...status.keys.map((label) => _buildStatRow(label)).toList(),
          const SizedBox(height: 20),
          NeumorphicButton(
            onPressed: enhancePoint == 0
                ? null
                : () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('強化の確認'),
                        content: const Text('この内容でステータスを強化しますか？'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('はい'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      Navigator.of(context).pop(status);
                    }
                  },
            child: Center(
              child: Text(
                'ポイントを使って強化',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: enhancePoint == 0 ? Colors.grey : Colors.black, // ← 色を変える
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatRow(String label) {
    final int baseValue = base[label]!;
    final int currentValue = status[label]!;
    final int diff = currentValue - baseValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('$label: $baseValue', style: const TextStyle(fontSize: 16)),
              if (diff > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text('+$diff', style: const TextStyle(fontSize: 16, color: Colors.red)),
                )
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: currentValue > baseValue
                    ? () => setState(() => status[label] = currentValue - 1)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: enhancePoint < 50 && remainingPoint >= 100
                    ? () => setState(() => status[label] = currentValue + 1)
                    : null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
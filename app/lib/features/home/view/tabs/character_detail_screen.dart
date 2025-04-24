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
    final points = ref.read(homeViewModelProvider).points; // ← HomeStateのポイント

    final updatedStats = await showModalBottomSheet<Map<String, int>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TrainingModal(
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
                    const Text('攻撃スキル: ファイアボール', style: TextStyle(fontSize: 18)),
                    const Text('防御スキル: シールド', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    const Text('必殺技: メガフレア', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text(
                      '炎で敵を焼き尽くす必殺技。全体攻撃で大ダメージ。',
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NeumorphicButton(
                      onPressed: () {},
                      child: const Text('メインキャラにする', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NeumorphicButton(
                      onPressed: () => _openTrainingModal(context, ref),
                      child: const Text('育成', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NeumorphicButton(
                      onPressed: () {},
                      child: const Text('削除', textAlign: TextAlign.center),
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
  int get used => status.values.reduce((a, b) => a + b);
  int get remaining => widget.totalPoints - used;

  @override
  void initState() {
    super.initState();
    status = Map<String, int>.from(widget.initialStats);
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      radius: 20,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('残りポイント: $remaining', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          ...status.keys.map((label) => _buildStatRow(label)).toList(),
          const SizedBox(height: 20),
          NeumorphicButton(
            onPressed: () {
              Navigator.of(context).pop(status);
            },
            child: const Center(child: Text('保存', style: TextStyle(fontWeight: FontWeight.bold))),
          )
        ],
      ),
    );
  }

  Widget _buildStatRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label: ${status[label]}', style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: status[label]! > 0
                    ? () => setState(() => status[label] = status[label]! - 1)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: remaining > 0
                    ? () => setState(() => status[label] = status[label]! + 1)
                    : null,
              ),
            ],
          )
        ],
      ),
    );
  }
}

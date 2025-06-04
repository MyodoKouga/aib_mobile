import 'package:flutter/material.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/view_model/training_modal_view_model.dart';

class TrainingModal extends ConsumerStatefulWidget {
  final Map<String, int> initialStats;
  final int totalPoints;
  final int charId;
  final int totalUsePoint;

  const TrainingModal({
    Key? key,
    required this.initialStats,
    required this.totalPoints,
    required this.charId,
    required this.totalUsePoint,
  }) : super(key: key);

  @override
  ConsumerState<TrainingModal> createState() => _TrainingModalState();
}

class _TrainingModalState extends ConsumerState<TrainingModal> {
  late Map<String, int> status;
  late Map<String, int> base;

  int get usedPoint => status.entries
      .map((e) => e.value - base[e.key]!)
      .fold(0, (a, b) => a + b);

  static const int maxEnhanceLimit = 50;
  late int currentEnhanceCount; // 今回の強化回数（初期は0）
  int get totalUsedPoint => widget.totalUsePoint;
  int get enhanceCount => totalUsedPoint ~/ 100;
  int get remainingPoint => widget.totalPoints - (usedPoint * 100);
  int get remainingEnhanceLimit => maxEnhanceLimit - widget.totalUsePoint;

  @override
  void initState() {
    super.initState();
    status = Map<String, int>.from(widget.initialStats);
    base = Map<String, int>.from(widget.initialStats);
    currentEnhanceCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: NeumorphicContainer(
              radius: 20,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('ステータス強化', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text('所持ポイント: $remainingPoint p', style: const TextStyle(fontSize: 18)),
                  const Text('(100 p = 能力強化１)', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 16),
                  Text('強化合計: ${enhanceCount + currentEnhanceCount} / 50', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  ...status.keys.map((label) => _buildStatRow(label)).toList(),
                  const SizedBox(height: 20),
                  NeumorphicButton(
                    onPressed: usedPoint == 0
                        ? null
                        : () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('強化の確認'),
                                content: const Text('この内容でステータスを強化しますか？'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('キャンセル')),
                                  TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('はい')),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              final userId = 1;
                              final success1 = await TrainingModalViewModel.submitTraining(
                                userId: userId,
                                charId: widget.charId,
                                usePoint: usedPoint * 100,
                                updatedStats: status,
                              );
                              final success2 = await TrainingModalViewModel.submitPointLog(
                                userId: userId,
                                pointInfo: 'ステータス強化',
                                usePoint: usedPoint * 100,
                              );
                              if (success1 && success2) {
                                Navigator.of(context).pop(status);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('強化に失敗しました')),
                                );
                              }
                            }
                          },
                    child: Text(
                      'ポイントを使って強化',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: usedPoint == 0 ? Colors.grey : Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label) {
    final baseValue = base[label]!;
    final currentValue = status[label]!;
    final diff = currentValue - baseValue;

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
                  padding: const EdgeInsets.only(left: 6),
                  child: Text('+$diff', style: const TextStyle(fontSize: 16, color: Colors.red)),
                ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: currentValue > baseValue
                  ? () => setState(() {
                      status[label] = currentValue - 1;
                      currentEnhanceCount--; // 戻すときはデクリメント
                    })
                  : null,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: (enhanceCount + currentEnhanceCount) < 50 && remainingPoint >= 100
                  ? () => setState(() {
                      status[label] = currentValue + 1;
                      currentEnhanceCount++; // 1回強化したことをカウント
                    })
                  : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


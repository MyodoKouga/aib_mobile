import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/training_modal_view_model.dart';

class ExchangePointModal extends ConsumerStatefulWidget {
  const ExchangePointModal({super.key});

  @override
  ConsumerState<ExchangePointModal> createState() => _ExchangePointModalState();
}

class _ExchangePointModalState extends ConsumerState<ExchangePointModal> {
  int? _selectedAmount;
  final List<int> _amounts = const [1000, 2000, 3000, 5000, 10000];

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
                  const Text('ポイント交換',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  ..._amounts.map(
                    (amount) => RadioListTile<int>(
                      title: Text('$amount p'),
                      value: amount,
                      groupValue: _selectedAmount,
                      onChanged: (value) => setState(() => _selectedAmount = value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  NeumorphicButton(
                    onPressed: _selectedAmount == null
                        ? null
                        : () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('交換の確認'),
                                content: Text('${_selectedAmount}pと交換しますか？'),
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
                              final userId = ref.read(homeViewModelProvider).userId;
                              if (userId == null) return;
                              final success = await TrainingModalViewModel.submitPointLog(
                                userId: userId,
                                pointInfo: 'ポイント交換',
                                usePoint: _selectedAmount!,
                              );
                              if (success && mounted) {
                                Navigator.of(context).pop(_selectedAmount);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('ポイント交換に失敗しました')),
                                );
                              }
                            }
                          },
                    child: Text(
                      '交換する',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedAmount == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

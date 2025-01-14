import 'package:flutter/material.dart';

class EditProfileDialog extends StatelessWidget {
  final String title; // ダイアログのタイトル
  final String currentValue; // 現在の値
  final Function(String) onSave; // 保存時のコールバック

  const EditProfileDialog({
    Key? key,
    required this.title,
    required this.currentValue,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: currentValue);

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: "新しい値を入力してください"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("キャンセル"),
        ),
        ElevatedButton(
          onPressed: () {
            onSave(controller.text); // 保存処理
            Navigator.pop(context); // ダイアログを閉じる
          },
          child: const Text("保存"),
        ),
      ],
    );
  }
}

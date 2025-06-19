import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class EditProfileDialog extends StatefulWidget {
  final String title;
  final String currentValue;
  final Future<void> Function(String) onSave;

  const EditProfileDialog({
    Key? key,
    required this.title,
    required this.currentValue,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _controller;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasChanges = _controller.text != widget.currentValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isBioEdit = widget.title == "自己紹介編集";
    final inputText = _controller.text.trim();
    final isInputValid = inputText.isNotEmpty;

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 300.w, // ダイアログの最大幅を設定
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBioEdit)
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'あなたのことを教えてください',
                  contentPadding: EdgeInsets.all(16.w),
                ),
                maxLines: 5,
                minLines: 3,
                textAlignVertical: TextAlignVertical.top,
                maxLength: 200, // 最大文字数を設定
              )
            else
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "新しい値を入力してください",
                  errorText: !isInputValid && _hasChanges ? "入力は必須です" : null,
                ),
                maxLength: isBioEdit ? null : 30, // ユーザー名の場合は最大30文字
              ),
          ],
        ),
      ),
      actions: [
        NeumorphicButton(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          onPressed: () => Navigator.pop(context),
          child: const Text("キャンセル"),
        ),
        NeumorphicButton(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          onPressed: (!isInputValid || !_hasChanges)
              ? null
              : () async {
                  await widget.onSave(inputText);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
          child: const Text("保存"),
        ),
      ],
    );
  }
}

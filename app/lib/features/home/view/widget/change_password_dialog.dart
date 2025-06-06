import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/home_view_model.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class ChangePasswordDialog extends ConsumerStatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  ConsumerState<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends ConsumerState<ChangePasswordDialog> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);
    final notifier = ref.read(profileViewModelProvider.notifier);
    final userId = ref.watch(homeViewModelProvider).userId;

    return AlertDialog(
      title: const Text('パスワードを変更'),
      content: SizedBox(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _oldPasswordController,
              decoration: const InputDecoration(labelText: '現在のパスワード'),
              obscureText: true,
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(labelText: '新しいパスワード'),
              obscureText: true,
            ),
          ],
        ),
      ),
      actions: [
        NeumorphicButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        NeumorphicButton(
          onPressed: profileState.isLoading
              ? null
              : () async {
                  final oldPass = _oldPasswordController.text.trim();
                  final newPass = _newPasswordController.text.trim();
                  if (userId != null &&
                      oldPass.isNotEmpty &&
                      newPass.isNotEmpty) {
                    final success = await notifier.changePassword(
                      userId: userId,
                      oldPassword: oldPass,
                      newPassword: newPass,
                    );
                    final updated = ref.read(profileViewModelProvider);
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'パスワードを変更しました'
                                : updated.errorMessage ??
                                    'パスワードの変更に失敗しました',
                          ),
                        ),
                      );
                    }
                  }
                },
          child: profileState.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('保存'),
        ),
      ],
    );
  }
}

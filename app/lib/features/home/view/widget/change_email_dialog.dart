import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/home_view_model.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class ChangeEmailDialog extends ConsumerStatefulWidget {
  const ChangeEmailDialog({super.key});

  @override
  ConsumerState<ChangeEmailDialog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends ConsumerState<ChangeEmailDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _message;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    ref.read(profileViewModelProvider.notifier).resetErrorMessage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);
    final notifier = ref.read(profileViewModelProvider.notifier);
    final userId = ref.watch(homeViewModelProvider).userId;

    return AlertDialog(
      title: const Text('メールアドレスを変更'),
      content: SizedBox(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (profileState.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  profileState.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '新しいメールアドレス'),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '現在のパスワード'),
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
                  final newEmail = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  if (newEmail.isEmpty || !newEmail.contains('@')) {
                    notifier.setErrorMessage('正しいメールアドレスを入力してください。');
                    return;
                  }
                  if (password.isEmpty || password.length < 6) {
                    notifier.setErrorMessage('パスワードは6文字以上で入力してください。');
                    return;
                  }
                  if (userId != null) {
                    final success = await notifier.changeEmail(
                      userId: userId,
                      password: password,
                      newEmail: newEmail,
                    );
                    final updated = ref.read(profileViewModelProvider);
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'メールアドレスを変更しました'
                                : updated.errorMessage ??
                                    'メールアドレスの変更に失敗しました',
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

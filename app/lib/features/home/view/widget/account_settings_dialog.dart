import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/profile_view_model.dart';
import 'change_email_dialog.dart';
import 'change_password_dialog.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class AccountSettingsDialog extends ConsumerWidget {
  const AccountSettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(profileViewModelProvider).email;

    return AlertDialog(
      title: const Text('ユーザー登録情報変更'),
      content: SizedBox(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('現在のメールアドレス: $email'),
            SizedBox(height: 24.h),
            NeumorphicButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) => const ChangeEmailDialog(),
                );
              },
              child: const Text('メールアドレスを変更'),
            ),
            SizedBox(height: 16.h),
            NeumorphicButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) => const ChangePasswordDialog(),
                );
              },
              child: const Text('パスワードを変更'),
            ),
          ],
        ),
      ),
      actions: [
        NeumorphicButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}

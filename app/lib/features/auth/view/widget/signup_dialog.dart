// signup_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/auth/view_model/auth_view_model.dart';
import '../../../home/view/home_screen.dart';

class SignupDialog extends ConsumerStatefulWidget {
  const SignupDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupDialogState();
}

class _SignupDialogState extends ConsumerState<SignupDialog> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    // ダイアログをフルスクリーンではなく、AlertDialogベースで作る例
    return AlertDialog(
      title: const Text('新規登録'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 300.w, // ダイアログの最大幅
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // エラー表示
              if (authState.errorMessage != null) ...[
                Text(
                  authState.errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
                SizedBox(height: 16.h),
              ],

              // メールアドレス入力
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                ),
              ),
              SizedBox(height: 16.h),

              // パスワード入力
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
      actions: [
        // キャンセルボタン
        TextButton(
          onPressed: authState.isLoading
              ? null
              : () {
                  // ダイアログを閉じる
                  Navigator.pop(context);
                },
          child: const Text('キャンセル'),
        ),

        // 登録ボタン
        ElevatedButton(
          onPressed: authState.isLoading
              ? null
              : () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  await ref
                      .read(authViewModelProvider.notifier)
                      .signUpWithEmail(email, password);

                  // 登録が成功したかをチェック
                  final updatedState = ref.read(authViewModelProvider);
                  if (!updatedState.isLoading &&
                      updatedState.errorMessage == null) {
                    // ダイアログを閉じる
                    if (mounted) {
                      Navigator.pop(context);
                    }

                    // HomeScreenへ遷移
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  }
                },
          child: authState.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('登録'),
        ),
      ],
    );
  }
}

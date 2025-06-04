import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/auth/view_model/auth_view_model.dart';
import '../../../home/view/home_screen.dart';
import '../../../home/view_model/home_view_model.dart';
import 'package:app/features/auth/view_model/terminal_id_view_model.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class SignupDialog extends ConsumerStatefulWidget {
  const SignupDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupDialogState();
}

class _SignupDialogState extends ConsumerState<SignupDialog> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final terminalIdAsync = ref.watch(terminalIdProvider);

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
              if (authState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    authState.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              // ユーザー名入力
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'ユーザー名',
                ),
              ),
              SizedBox(height: 16.h),

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
        NeumorphicButton(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          onPressed: authState.isLoading
              ? null
              : () {
                  // ダイアログを閉じる
                  Navigator.pop(context);
                },
          child: const Text('キャンセル'),
        ),

        // 登録ボタン
        NeumorphicButton(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          onPressed: authState.isLoading
              ? null
              : () async {
                  final username = usernameController.text.trim();
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  // 入力バリデーション
                  if (username.isEmpty) {
                    ref.read(authViewModelProvider.notifier).setErrorMessage('ユーザー名を入力してください。');
                    return;
                  }
                  if (email.isEmpty || !email.contains('@')) {
                    ref.read(authViewModelProvider.notifier).setErrorMessage('正しいメールアドレスを入力してください。');
                    return;
                  }
                  if (password.isEmpty || password.length < 6) {
                    ref.read(authViewModelProvider.notifier).setErrorMessage('パスワードは6文字以上で入力してください。');
                    return;
                  }

                  final terminalId = await ref.read(terminalIdProvider.future) ?? '';

                  await ref
                      .read(authViewModelProvider.notifier)
                      .signUpWithUsernameEmailAndPassword(username, email, password, terminalId);

                  // 登録が成功したかをチェック
                  final updatedState = ref.read(authViewModelProvider);
                  if (!updatedState.isLoading &&
                      updatedState.errorMessage == null) {
                    // ダイアログを閉じる
                    if (mounted) {
                      Navigator.pop(context);
                    }

                    // HomeScreenへ遷移前にチュートリアル初期化
                    ref.read(homeViewModelProvider.notifier).initializeTutorial();

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

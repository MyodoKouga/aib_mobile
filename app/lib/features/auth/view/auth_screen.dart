// auth_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../home/view/home_screen.dart';
import 'package:app/features/auth/view/widget/signup_dialog.dart';
import '../../home/view_model/home_view_model.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AIバトルアプリへようこそ',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.h),

              // モーダルを開くボタン
              SizedBox(
                width: double.infinity,
                child: NeumorphicButton(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  onPressed: () {
                    // showDialogを使ってモーダルを開く
                    showDialog(
                      context: context,
                      builder: (_) => const SignupDialog(),
                    );
                  },
                  child: Text(
                    'メールアドレスで登録',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // 引き継ぎ
              SizedBox(
                width: double.infinity,
                child: NeumorphicButton(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  onPressed: () {
                    // showDialogを使ってモーダルを開く
                    showDialog(
                      context: context,
                      builder: (_) => const SignupDialog(),
                    );
                  },
                  child: Text(
                    'アカウントを引き継ぐ',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // スキップボタン
              NeumorphicButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                onPressed: () {
                  // HomeScreenへ遷移前にチュートリアル初期化
                  ref.read(homeViewModelProvider.notifier).initializeTutorial();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Text(
                  'スキップして始める',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

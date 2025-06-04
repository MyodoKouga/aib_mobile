import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/home_view_model.dart';
import '../widget/edit_profile_dialog.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  @override
  void initState() {
    super.initState();

    // ローカルデータを読み込む
    ref.read(profileViewModelProvider.notifier).loadProfileFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileViewModelProvider);
    final profileNotifier = ref.read(profileViewModelProvider.notifier);
    final points = ref.watch(homeViewModelProvider).points;

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NeumorphicContainer(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ユーザー名', style: TextStyle(fontSize: 16.sp)),
                    Text(
                      profile.username.isEmpty ? 'ゲスト' : profile.username,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              NeumorphicButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => EditProfileDialog(
                      title: 'ユーザー登録情報変更',
                      currentValue: profile.username,
                      onSave: (value) {
                        profileNotifier.updateProfile(value, profile.bio);
                      },
                    ),
                  );
                },
                child: Text('ユーザー登録情報変更', style: TextStyle(fontSize: 16.sp)),
              ),
              SizedBox(height: 24.h),
              NeumorphicContainer(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('所持ポイント', style: TextStyle(fontSize: 16.sp)),
                    Text('$points p',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: NeumorphicButton(
                  onPressed: () {
                    // ポイント交換処理
                  },
                  child: Text('ポイントを交換する',
                      style: TextStyle(fontSize: 16.sp), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

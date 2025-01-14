import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/edit_profile_dialog.dart';
import '../../view_model/profile_view_model.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // プロフィール画像
                CircleAvatar(
                  radius: 50.w,
                  backgroundImage: NetworkImage(
                      profile.avatarUrl.isNotEmpty ? profile.avatarUrl : "https://via.placeholder.com/150"),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        // TODO: プロフィール画像の変更機能を追加
                      },
                      child: CircleAvatar(
                        radius: 15.w,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // ユーザー名
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profile.username.isNotEmpty ? profile.username : 'ゲスト',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditProfileDialog(
                            title: "ユーザー名編集",
                            currentValue: profile.username,
                            onSave: (value) {
                              profileNotifier.updateProfile(value, profile.bio);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // 自己紹介文
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "自己紹介",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        profile.bio.isNotEmpty ? profile.bio : 'よろしくお願いします！',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => EditProfileDialog(
                                title: "自己紹介編集",
                                currentValue: profile.bio,
                                onSave: (value) {
                                  profileNotifier.updateProfile(profile.username, value);
                                },
                              ),
                            );
                          },
                          child: const Text("編集"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ローディングインジケーター
          if (profile.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // エラーメッセージ表示
          if (profile.errorMessage != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Center(
                  child: Text(
                    profile.errorMessage!,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

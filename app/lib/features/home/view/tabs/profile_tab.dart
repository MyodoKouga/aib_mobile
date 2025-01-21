import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/edit_profile_dialog.dart';
import '../../../auth/view/widget/signup_dialog.dart';
import '../../view_model/profile_view_model.dart';
import '../widget/image_picker.dart';

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
                // プロフィール
                if (!profile.isGuest && !profile.hasCompleteProfile)
                  Container(
                    padding: EdgeInsets.all(8.w),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'プロフィールを完成させましょう！',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),

                // （※必要であれば）メール認証バナー
                // if (!profile.isGuest && !profile.isEmailVerified && profile.email.isNotEmpty)
                //   Container(
                //     padding: EdgeInsets.all(8.w),
                //     margin: EdgeInsets.only(bottom: 16.h),
                //     decoration: BoxDecoration(
                //       color: Colors.blue.shade100,
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Row(
                //       children: [
                //         const Icon(Icons.info, color: Colors.blue),
                //         SizedBox(width: 8.w),
                //         const Expanded(
                //           child: Text('メールアドレスの認証を完了してください'),
                //         ),
                //         TextButton(
                //           onPressed: () {
                //             // TODO: メール認証処理の実装
                //           },
                //           child: const Text('認証する'),
                //         ),
                //       ],
                //     ),
                //   ),

                // プロフィール画像
                CircleAvatar(
                  radius: 50.w,
                  backgroundImage: profile.avatarUrl.startsWith('http')
                      ? NetworkImage(
                          profile.avatarUrl.isNotEmpty ? profile.avatarUrl : "https://via.placeholder.com/150")
                      : profile.avatarUrl.isNotEmpty
                          ? FileImage(File(profile.avatarUrl)) as ImageProvider
                          : const NetworkImage("https://via.placeholder.com/150"),
                  child: !profile.isGuest
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ImagePickerBottomSheet(
                                  onSourceSelected: (source) {
                                    Navigator.pop(context);
                                    profileNotifier.uploadProfileImage(source);
                                  },
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 15.w,
                              backgroundColor: Colors.blue,
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                            ),
                          ),
                        )
                      : null,
                ),
                // エラーメッセージ表示
                if (profile.errorMessage != null || profile.imageUploadError != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Center(
                        child: Text(
                          profile.imageUploadError ?? profile.errorMessage!,
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16.h),

                // ゲスト登録ボタン
                if (profile.isGuest)
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const SignupDialog(),
                      );
                    },
                    child: Text('アカウント登録', style: TextStyle(fontSize: 14.sp)),
                  ),
                SizedBox(height: 16.h),

                // ユーザー名
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profile.username.isEmpty ? 'ゲスト' : profile.username,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    if (!profile.isGuest)
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
                if (!profile.isGuest)
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

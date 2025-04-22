import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/home/view/tabs/home_tab.dart';
import 'package:app/features/home/view/tabs/list_tab.dart';
import 'package:app/features/home/view/tabs/battle_tab.dart';
import 'package:app/features/home/view/tabs/profile_tab.dart';
import 'package:app/features/home/model/bottom_nav_item.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/view/widget/neumorphic_bottom_nav.dart';
import 'package:app/features/home/view/widget/animated_tab_container.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      appBar: _buildNeumorphicAppBar(context, ref),
      body: Stack(
        children: [
          _buildBody(homeState),
          if (homeState.isLoading) _buildLoadingOverlay(),
          if (homeState.showTutorialDialog) _buildNeumorphicTutorialDialog(context, ref),
          if (homeState.showNotificationModal) _buildNotificationModal(context, ref),
        ],
      ),
      bottomNavigationBar: NeumorphicBottomNav(),
    );
  }

  PreferredSizeWidget _buildNeumorphicAppBar(BuildContext context, WidgetRef ref) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56.h),
      child: NeumorphicContainer(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('AIバトル', style: TextStyle(fontSize: 18.sp)),
          actions: [
            NeumorphicContainer(
              isPressed: false,
              radius: 30,
              child: IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // TODO: お知らせ画面モーダルの表示
                  ref.read(homeViewModelProvider.notifier).openNotificationModal();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // お知らせモーダル用ウィジェット
  Widget _buildNotificationModal(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: NeumorphicContainer(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('お知らせ', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              Text(
                '最新のアップデート情報やイベント情報をここに表示できます！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              NeumorphicButton(
                onPressed: () => ref.read(homeViewModelProvider.notifier).closeNotificationModal(),
                child: Text('閉じる', style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ロード中のオーバーレイ
  Widget _buildLoadingOverlay() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildNeumorphicTutorialDialog(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: NeumorphicContainer(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ようこそ', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              Text(
                'まずは、キャラクターを作成してみましょう！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              NeumorphicButton(
                onPressed: () => ref.read(homeViewModelProvider.notifier).closeTutorialDialog(),
                child: Text('次へ', style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // シンプル実装
  // Widget _buildBody(HomeState state) {
  //   switch (state.currentTab) {
  //     case BottomNavItem.home:
  //       return const HomeTab();
  //     case BottomNavItem.battle:
  //       return const BattleTab();
  //     case BottomNavItem.profile:
  //       return const ProfileTab();
  //   }
  // }

  // アニメーション付き画面の表示切り替え
  Widget _buildBody(HomeState state) {
    return AnimatedTabContainer(
      child: KeyedSubtree(
        key: ValueKey<BottomNavItem>(state.currentTab),
        child: switch (state.currentTab) {
          BottomNavItem.home => HomeTab(),
          BottomNavItem.list => const ListTab(),
          BottomNavItem.battle => const BattleTab(),
          BottomNavItem.profile => const ProfileTab(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/home/view/tabs/home_tab.dart';
import 'package:app/features/home/view/tabs/battle_tab.dart';
import 'package:app/features/home/view/tabs/profile_tab.dart';
import 'package:app/features/home/model/bottom_nav_item.dart';
import 'package:app/features/home/model/home_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AIバトル',
          style: TextStyle(fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: お知らせ画面への遷移
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildBody(homeState),
          if (homeState.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          
          // チュートリアルダイアログ
          if (homeState.showTutorialDialog) _buildTutorialDialog(context, ref),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: BottomNavItem.values.indexOf(homeState.currentTab),
        items: BottomNavItem.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            label: tab.label,
          );
        }).toList(),
        onTap: (index) {
          ref.read(homeViewModelProvider.notifier).changeTab(BottomNavItem.values[index]);
        },
      ),
    );
  }

  Widget _buildBody(HomeState state) {
    switch (state.currentTab) {
      case BottomNavItem.home:
        return const HomeTab();
      case BottomNavItem.battle:
        return const BattleTab();
      case BottomNavItem.profile:
        return const ProfileTab();
    }
  }
  
  Widget _buildTutorialDialog(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ようこそ',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'まずは、キャラクターを作成してみましょう！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  ref.read(homeViewModelProvider.notifier).closeTutorialDialog();
                },
                child: Text(
                  '次へ',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

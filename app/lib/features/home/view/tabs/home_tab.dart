import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/create/view/select_char_pattern_screen.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    if (homeState.errorMessage != null) {
      return _buildErrorView(context, ref, homeState.errorMessage!);
    }

    return Stack(
      children: [
        _buildMainContent(context),
        if (homeState.showTutorialOverlay) _buildTutorialOverlay(),
        _buildCreateButton(context, ref, homeState),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: NeumorphicContainer(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            NeumorphicButton(
              onPressed: () => ref.read(homeViewModelProvider.notifier).loadCharacters(),
              child: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: NeumorphicContainer(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'マイキャラクター',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            const Center(child: Text('キャラクターがまだありません')),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: Opacity(opacity: 0, child: _buildHiddenButton()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHiddenButton() {
    return NeumorphicButton(
      onPressed: null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Text('キャラクターを作成'),
      ),
    );
  }

  Widget _buildTutorialOverlay() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: NeumorphicContainer(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'キャラクターを作成して\nAIバトルを始めましょう！',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context, WidgetRef ref, HomeState homeState) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      bottom: 16.h,
      child: NeumorphicContainer(
        isPressed: homeState.showTutorialOverlay,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: NeumorphicButton(
            onPressed: () => _handleCreateButtonPress(context, ref, homeState),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text('キャラクターを作成', style: TextStyle(fontSize: 16.sp)),
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateButtonPress(BuildContext context, WidgetRef ref, HomeState homeState) {
    if (homeState.showTutorialOverlay) {
      ref.read(homeViewModelProvider.notifier).completeTutorial();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SelectCharPatternScreen()),
    );
  }
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
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
        Column(
          children: [
            Flexible(child: _buildMainContent(context, ref)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  Expanded(child: _buildCreateButton(context, ref, homeState, 150.h)),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildBattleButton(context, ref, homeState, 150.h)),
                ],
              ),
            ),
          ],
        ),
        if (homeState.showTutorialOverlay) _buildTutorialOverlay(ref),
      ],
    );
  }

Widget _buildMainContent(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenHeight * 0.02;
    final verticalPadding = screenHeight * 0.01;
    final containerHeight = screenHeight * 0.5;
    final innerPadding = screenHeight * 0.01;
    final sizedBoxHeightLarge = screenHeight * 0.02;
    final sizedBoxHeightSmall = screenHeight * 0.02;
    final titleFontSize = screenHeight * 0.03;
    final textFontSize = screenHeight * 0.025;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: SizedBox(
        height: containerHeight,
        child: NeumorphicContainer(
          padding: EdgeInsets.all(innerPadding),
          radius: 20.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'マイキャラクター',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: sizedBoxHeightLarge),
              homeState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : homeState.characterImage != null
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Image.memory(
                                  homeState.characterImage!,
                                  width: screenHeight * 0.3,
                                  height: screenHeight * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: sizedBoxHeightLarge),
                              Text(
                                homeState.characterName ?? '',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: sizedBoxHeightSmall),
                              Text(
                                homeState.specialMove ?? '',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Text(
                            '画像の取得に失敗しました',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context, WidgetRef ref, HomeState homeState, double buttonHeight) {
    return SizedBox(
      height: buttonHeight,
      child: NeumorphicButton(
        onPressed: () => ref.read(homeViewModelProvider.notifier).handleCreateButtonPress(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.create, size: 64.sp, color: Colors.blue),
            SizedBox(height: 12.h),
            Text('キャラクター作成', style: TextStyle(fontSize: 14.sp, color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleButton(BuildContext context, WidgetRef ref, HomeState homeState, double buttonHeight) {
    return SizedBox(
      height: buttonHeight,
      child: NeumorphicButton(
        onPressed: () => ref.read(homeViewModelProvider.notifier).handleBattleButtonPress(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sports_martial_arts, size: 64.sp, color: Colors.red),
            SizedBox(height: 12.h),
            Text('バトルする', style: TextStyle(fontSize: 14.sp, color: Colors.red)),
          ],
        ),
      ),
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

  Widget _buildTutorialOverlay(WidgetRef ref) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: NeumorphicContainer(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'キャラクターを作成して\nAIバトルを始めましょう！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  NeumorphicButton(
                    onPressed: () => ref.read(homeViewModelProvider.notifier).completeTutorial(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

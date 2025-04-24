import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/main.dart';


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
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
              child: _buildSubContent(context, ref),
            ),
            Flexible(child: _buildMainContent(context, ref)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(child: _buildCreateButton(context, ref, homeState, 140.h)),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildBattleButton(context, ref, homeState, 140.h)),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildAdButton(context, ref, homeState, 140.h)),
                ],
              ),
            ),
          ],
        ),
        if (homeState.showTutorialOverlay) _buildTutorialOverlay(ref),
      ],
    );
  }

  // Homeメイン部分
  Widget _buildMainContent(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenHeight * 0.02;
    final verticalPadding = screenHeight * 0.01;
    final containerHeight = screenHeight * 0.45;
    final innerPadding = screenHeight * 0.01;
    final sizedBoxHeightLarge = screenHeight * 0.02;
    final titleFontSize = screenHeight * 0.02;
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
                'メインキャラクター',
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
                              // SizedBox(height: sizedBoxHeightLarge),
                              Text(
                                homeState.characterName ?? '',
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
  
  // Home上部情報部分
  Widget _buildSubContent(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final subContainerHeight = screenHeight * 0.08;
    final innerPadding = screenHeight * 0.01;
    final homeState = ref.watch(homeViewModelProvider);

    return SizedBox(
      height: subContainerHeight,
      child: NeumorphicContainer(
        padding: EdgeInsets.all(innerPadding),
        radius: 20.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // ← 横並びの余白調整
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('所有ポイント'),
                //バックエンドからAPIでポイント数を取得
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${homeState.points} p',
                    // '1000 p',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    )
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBattleStatus(homeState, ref),
              ],
            )
          ],
        ),
      ),
    );
  }
  
  // キャラ作成ボタン
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
            Text('キャラクター作成', style: TextStyle(fontSize: 12.sp, color: Colors.blue), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // バトルボタン
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

  // リワード広告見るボタン
  Widget _buildAdButton(BuildContext context, WidgetRef ref, HomeState homeState, double buttonHeight) {
    return SizedBox(
      height: buttonHeight,
      child: NeumorphicButton(
        // このボタンを押したらリワード広告
        onPressed: () => RewardAdHelper.showRewardedAd(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.savings, size: 64.sp, color: Colors.orange),
            SizedBox(height: 12.h),
            Text('ポイントをゲットする', style: TextStyle(fontSize: 14.sp, color: Colors.orange), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // エラー表示
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

  // バトル待機ウィジェット
  Widget _buildBattleStatus(HomeState homeState, WidgetRef ref) {
    final battleFlg = homeState.battleFlg;
    // final battleFlg = 2;

    final battleStatusMap = {
      0: 'バトル未参加',
      1: 'バトル待機中',
      2: 'バトル完了',
    };

    if (battleFlg == 2) {
      return TextButton(
        onPressed: () {
          // バトル終了後の処理（結果を見る画面へ）
          print('バトル終了ボタン押下');
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          battleStatusMap[battleFlg]!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      );
    }

    return Text(
      battleStatusMap[battleFlg] ?? '不明',
      style: TextStyle(
        color: battleFlg == 1
            ? Colors.red
            : Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
      ),
    );
  }

  // チュートリアルオーバーレイ
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

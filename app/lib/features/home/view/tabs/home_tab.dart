import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/create/view/select_char_pattern_screen.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    if (homeState.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              homeState.errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).loadCharacters();
              },
              child: const Text('再試行'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        // 背景のコンテンツ（ボタン以外）
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'マイキャラクター',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              const Center(
                child: Text('キャラクターがまだありません'),
              ),
              SizedBox(height: 16.h),

              SizedBox(
                width: double.infinity,
                child: Opacity(
                  opacity: 0,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: const Text('キャラクターを作成'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // チュートリアルのオーバーレイ
        if (homeState.showTutorialOverlay)
          Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
            ),
          ),

        // キャラクター作成ボタン
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.sp + 16.h), // タイトルの高さ分
              SizedBox(height: 16.h), // 最初のスペース
              SizedBox(height: 24.h), // テキストの高さ分
              SizedBox(height: 16.h), // 2番目のスペース
              SizedBox(
                width: double.infinity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: homeState.showTutorialOverlay
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 8,
                            )
                          ]
                        : null,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (homeState.showTutorialOverlay) {
                        ref.read(homeViewModelProvider.notifier).completeTutorial();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectCharPatternScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        'キャラクターを作成',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
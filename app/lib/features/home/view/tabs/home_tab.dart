import 'dart:ui';
import 'dart:convert'; 
import 'dart:typed_data'; 
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/home/model/home_state.dart';
import 'package:app/features/home/view_model/home_view_model.dart';
import 'package:app/features/create/view/select_char_pattern_screen.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_button.dart';
import 'package:app/shared/widget/neumorphic/neumorphic_container.dart';
import 'package:app/shared/widget/neumorphic/animated_neumorphic_container.dart';

class HomeTab extends ConsumerWidget {
  HomeTab({super.key});

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

            // 画像を取得して表示
            Consumer(
              builder: (context, ref, child) {
                final charImageState = ref.watch(charDataProvider);

                return charImageState.when(
                  data: (imageData) => Column(
                    children: [
                      Center(
                        child: Image.memory(
                          imageData,
                          width: 300.w,
                          height: 300.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // キャラクター名
                      Text(
                        'キャラクター名: テストキャラ',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),

                      // 必殺技
                      Text(
                        '必殺技: ファイナルストライク',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(
                    child: Text('画像の取得に失敗しました', style: TextStyle(color: Colors.red)),
                  ),
                );
              },
            ),

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
      // a) シンプル実装
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
      // b) アニメーションコンテナでの実装
      // child: AnimatedNeumorphicContainer(
      //   isPressed: homeState.showTutorialOverlay,
      //   padding: EdgeInsets.symmetric(vertical: 12.h),
      //   child: NeumorphicButton(
      //     onPressed: () => _handleCreateButtonPress(context, ref, homeState),
      //     child: Text('キャラクターを作成', style: TextStyle(fontSize: 16.sp)),
      //   ),
      // ),
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

  // サーバ通信用のプロバイダ
  final charDataProvider = FutureProvider<Uint8List>((ref) async {
    try {
      final userId = 1;
      final mainCharId = 1;

      final url = Uri.parse('http://localhost:8000/get/char_image');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId, 'char_id': mainCharId}),
      );

      if (response.statusCode != 200) {
        throw Exception('サーバエラー: ${response.statusCode}');
      }

      return response.bodyBytes;
    } catch (e) {
      debugPrint('Error fetching image: $e');
      throw Exception('画像の取得に失敗しました');
    }
  });

}
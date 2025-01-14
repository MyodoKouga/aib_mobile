import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/features/auth/view/auth_screen.dart';
import 'package:app/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:app/features/onboarding/model/onboarding_content.dart';
import 'package:app/features/onboarding/view/onboarding_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  // ページデータ
  final List<OnboardingContent> pages = [
    OnboardingContent(
      title: 'AIバトル',
      description: 'あなただけのAIキャラクターを作成しよう！',
    ),
    OnboardingContent(
      title: 'バトル',
      description: '作成したキャラクターで対戦しよう！',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingProvider);

    // 次へ/始めるボタン押下時の処理
    Future<void> _onNextPressed() async {
      if (currentPage < pages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        // 初回起動フラグを更新
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstLaunch', false);

        // 認証画面に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ページビュー
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  ref.read(onboardingProvider.notifier).updatePage(page);
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: pages[index].title,
                    description: pages[index].description,
                  );
                },
              ),
            ),

            // ページインジケーターと次へ/始めるボタン
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      pages.length,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 8.w),
                        height: 8.h,
                        width: currentPage == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onNextPressed,
                    child: Text(
                      currentPage < pages.length - 1 ? '次へ' : '始める',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

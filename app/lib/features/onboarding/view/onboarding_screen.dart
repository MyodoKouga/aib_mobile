import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  ref.read(onboardingProvider.notifier).updatePage(page);
                },
                children: [
                  OnboardingPage(
                    title: 'AIバトル',
                    description: 'あなただけのAIキャラクターを作成しよう！',
                  ),
                  OnboardingPage(
                    title: 'バトル',
                    description: '作成したキャラクターで対戦しよう！',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      2,
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
                    onPressed: () {
                      if (currentPage < 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      currentPage < 1 ? '次へ' : '始める',
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

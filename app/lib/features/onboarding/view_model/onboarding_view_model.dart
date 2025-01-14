import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider<OnboardingViewModel, int>((ref) {
  return OnboardingViewModel();
});

class OnboardingViewModel extends StateNotifier<int> {
  OnboardingViewModel() : super(0);

  void updatePage(int page) {
    state = page;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/features/onboarding/view/onboarding_screen.dart';
import 'package:app/features/home/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初回起動判定
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(
    ProviderScope(
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhoneX をベースサイズとして設定
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'AI Battle App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // 初回起動なら OnboardingScreen、それ以外は HomeScreen
          home: isFirstLaunch ? const OnboardingScreen() : const HomeScreen(),
        );
      },
    );
  }
}

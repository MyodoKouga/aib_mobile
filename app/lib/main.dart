import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app/features/onboarding/view/onboarding_screen.dart';
import 'package:app/features/home/view/home_screen.dart';
import 'package:app/shared/providers/providers.dart';
import 'dart:io';
import 'package:app/features/auth/view_model/terminal_id_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final config = RequestConfiguration(testDeviceIds: ['SIMULATOR']);
  await MobileAds.instance.updateRequestConfiguration(config);
  await MobileAds.instance.initialize();

  // リワード広告を読み込む
  RewardAdHelper.loadRewardedAd();

  // 初回起動判定
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    final container = ProviderContainer();

    try {
      final terminalId = await container.read(terminalIdProvider.future);
      if (terminalId != null) {
        final success = await container
            .read(terminalIdRegisterProvider.notifier) // ✅ 修正ここ
            .registerTerminalId(terminalId); // ✅ メソッド名修正

        if (success) {
          print('✅ 初回端末ID登録: $terminalId');
          await prefs.setString('deviceId', terminalId);
          await prefs.setBool('isFirstLaunch', false);
        } else {
          print('❌ 端末ID登録失敗');
        }
      } else {
        print('❌ 端末ID取得失敗');
      }
    } catch (e) {
      print('❌ 端末ID処理中にエラー: $e');
    } finally {
      container.dispose(); // ✅ ProviderContainerの破棄
    }
  }

  runApp(
    ProviderScope(
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'AI Battle App',
          theme: ThemeData(primarySwatch: Colors.blue),
          builder: (context, child) {
            return MainScaffold(child: child!);
          },
          home: widget.isFirstLaunch
              ? const OnboardingScreen()
              : const HomeScreen(),
        );
      },
    );
  }
}

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAd = ref.watch(bannerAdProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            ),
          ),
        ],
      ),
    );
  }
}

class RewardAdHelper {
  static RewardedAd? _rewardedAd;

  static void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('❌ 広告読み込み失敗: $error');
        },
      ),
    );
  }

  static void showRewardedAd(BuildContext context) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('🎉 ユーザーが報酬を獲得！');
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('🎉 報酬ゲット！'),
              content: const Text('10ポイントを獲得しました！'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      );
      _rewardedAd = null;
      loadRewardedAd();
    } else {
      print('広告がまだ読み込まれていません。再読み込みします');
      loadRewardedAd();
    }
  }

  static void onRewardEarned() {
    // 必要があれば処理追加
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app/features/onboarding/view/onboarding_screen.dart';
import 'package:app/features/home/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // AdMobの初期化
  await MobileAds.instance.initialize();

  // 初回起動判定
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

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
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    RewardAdHelper.loadRewardedAd();

    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/2934735716', // テスト用ID
      listener: BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose(); // ← ちゃんと破棄！
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'AI Battle App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: widget.isFirstLaunch
                      ? const OnboardingScreen()
                      : const HomeScreen(),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white, // 背景で見切れ防止
                    width: double.infinity,
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RewardAdHelper {
  // リワード広告
  static RewardedAd? _rewardedAd; // ← 広告の変数

  // 広告を読み込む関数
  static void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // テスト広告ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad; // 読み込み成功
        },
        onAdFailedToLoad: (error) {
          print('広告の読み込み失敗: $error');
        },
      ),
    );
  }

  // 広告を表示する関数
  static void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('ユーザーが報酬を獲得しました！');
          // 👇 ここでポイント加算とかする
          // onRewardEarned();
        },
      );
      _rewardedAd = null;
      loadRewardedAd(); // 次の広告も読み込んでおく
    } else {
      print('広告がまだ読み込まれていません');
    }
  }

  static void onRewardEarned() {
    
  }
}
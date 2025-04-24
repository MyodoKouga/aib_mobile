import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final bannerAdProvider = Provider.autoDispose<BannerAd>((ref) {
  final ad = BannerAd(
    size: AdSize.banner,
    adUnitId: 'ca-app-pub-3940256099942544/2934735716',
    listener: BannerAdListener(),
    request: const AdRequest(),
  )..load();

  ref.onDispose(() {
    ad.dispose(); // 解放
  });

  return ad;
});


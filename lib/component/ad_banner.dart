import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

// StatelessWidgetを継承して作成
class AdBanner extends StatelessWidget {
  const AdBanner({
    Key? key,
    required this.size,
  }) : super(key: key);

  final AdSize size;

  @override
  Widget build(BuildContext context) {
    final banner = BannerAd(
        size: size,
        adUnitId: BannerAd.testAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('Ad failed to load: $error');
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => print('Ad closed.'),
        ),
        request: const AdRequest())
      ..load();

    // 戻り値はContainerで包んで返す
    return SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner));
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return dotenv.get("ANDROID_ADSENSE_ID");
    } else if (Platform.isIOS) {
      return dotenv.get("IOS_ADSENSE_ID");
    } else {
      // iosでもAndroidでもない場合はテスト用のIdを返す
      return BannerAd.testAdUnitId;
    }
  }
}

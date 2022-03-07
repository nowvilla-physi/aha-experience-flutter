import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdBanner extends StatelessWidget {
  const AdBanner({
    Key? key,
    required this.size,
  }) : super(key: key);

  final AdSize size;

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return dotenv.get("ANDROID_ADSENSE_BANNER_ID");
    } else {
      return dotenv.get("IOS_ADSENSE_BANNER_ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    final banner = BannerAd(
        size: size,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print('Banner ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('Banner Ad failed to load: $error');
          },
          onAdOpened: (Ad ad) => print('Banner Ad opened.'),
          onAdClosed: (Ad ad) => print('Banner Ad closed.'),
        ),
        request: const AdRequest())
      ..load();

    return SizedBox(
        width: double.infinity,
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner));
  }
}

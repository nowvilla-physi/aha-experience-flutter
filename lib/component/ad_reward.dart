import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdReward {
  AdReward({required this.handleWatchAd});

  final Function handleWatchAd;
  RewardedAd? _rewardedAd;

  void showRewardedAd() {
    final rewardedAd = _rewardedAd;
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd.setImmersiveMode(true);
    rewardedAd.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      handleWatchAd();
    });
    _rewardedAd = null;
  }

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad reward loaded.');
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
          }
      ),
    );
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
      // return dotenv.get("ANDROID_ADSENSE_REWARD_ID"); // TODO 本番はこっちに切り替える
    } else {
      return "ca-app-pub-3940256099942544/1712485313";
      // return dotenv.get("IOS_ADSENSE_REWARD_ID");  // TODO 本番はこっちに切り替える
    }
  }
}

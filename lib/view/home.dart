import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends ConsumerWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  void toBeginnerMovies(BuildContext context) {
    Navigator.of(context).pushNamed(Strings.beginnerMoviesPath);
  }

  void toAdvancedMovies(BuildContext context) {
    Navigator.of(context).pushNamed(Strings.advancedMoviesPath);
  }

  void toDemonMovies(BuildContext context) {
    Navigator.of(context).pushNamed(Strings.demonMoviesPath);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.allPadding.w,
                vertical: Dimens.allPadding.h,
              ),
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/home-logo.png"),
                  AppSpacer(height: 64.h),
                  LevelSelectionButton(
                    key: const Key(Strings.beginnerButton),
                    name: Strings.beginnerButton,
                    handleTap: toBeginnerMovies,
                    backgroundColor: AppColors.beginner,
                  ),
                  AppSpacer(height: 24.h),
                  LevelSelectionButton(
                    key: const Key(Strings.advancedButton),
                    name: Strings.advancedButton,
                    handleTap: toAdvancedMovies,
                    backgroundColor: AppColors.advanced,
                  ),
                  AppSpacer(height: 24.h),
                  LevelSelectionButton(
                    key: const Key(Strings.demonButton),
                    name: Strings.demonButton,
                    handleTap: toDemonMovies,
                    backgroundColor: AppColors.demon,
                  ),
                ],
              ),
            ),
          ),
          // const Align(
          //   alignment: Alignment.bottomCenter,
          //   child: AdBanner(size: AdSize.fullBanner),
          // )
        ],
      ),
    );
  }
}

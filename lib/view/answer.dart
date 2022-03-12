import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class Answer extends StatelessWidget {
  const Answer({Key? key, required this.title, required this.item})
      : super(key: key);
  final String title;
  final DataItem item;

  @override
  Widget build(BuildContext context) {
    void toHome() {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Strings.homePath, (Route<dynamic> route) => false);
    }

    void toMovies() {
      final String target;
      switch (item.level) {
        case "beginner":
          if (item.isLastOfLevel) {
            target = Strings.advancedMoviesPath;
          } else {
            target = Strings.beginnerMoviesPath;
          }
          break;
        case "advanced":
          if (item.isLastOfLevel) {
            target = Strings.demonMoviesPath;
          } else {
            target = Strings.advancedMoviesPath;
          }
          break;
        case "demon":
          target = Strings.demonMoviesPath;
          break;
        default:
          target = Strings.beginnerMoviesPath;
      }
      Navigator.of(context).pushNamed(target);
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: Dimens.allMarginTop.h),
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.allPadding.w,
                vertical: Dimens.allPadding.h,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    Strings.answer,
                    style: TextStyle(color: AppColors.white, fontSize: 32.sp),
                  ),
                  AppSpacer(height: 32.h),
                  Text(
                    item.answer,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  AppSpacer(height: 48.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: Dimens.actionButtonMarginHorizontal.w,
                        ),
                        child: ActionButton(
                          name: Strings.homeButton,
                          textColor: AppColors.baseColor,
                          backgroundColor: AppColors.white,
                          handleTap: toHome,
                        ),
                      ),
                      if (item.id > 0 && item.id < 38)
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimens.actionButtonMarginHorizontal.w,
                          ),
                          child: ActionButton(
                            name: Strings.nextButton,
                            textColor: AppColors.white,
                            backgroundColor: AppColors.blue,
                            handleTap: toMovies,
                          ),
                        ),
                    ],
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
      )
    );
  }
}

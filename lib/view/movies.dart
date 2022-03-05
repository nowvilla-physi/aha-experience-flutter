import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class Movies extends StatefulWidget {
  const Movies({
    Key? key,
    required this.title,
    required this.level,
    required this.items,
  }) : super(key: key);
  final String title;
  final String level;
  final List<DataItem> items;

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  String _switchImage(DataItem item) {
    switch (item.level) {
      case "beginner":
        return "assets/images/ic_character_beginner.png";
      case "advanced":
        return "assets/images/ic_character_advanced.png";
      case "demon":
        return "assets/images/ic_character_demon.png";
      default:
        return "assets/images/ic_character_beginner.png";
    }
  }

  void toHome() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: Dimens.allMarginTop.h),
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.allPadding.w,
              vertical: Dimens.allPadding.h,
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.level,
                    style: TextStyle(color: AppColors.white, fontSize: 42.0.sp),
                  ),
                  SizedBox(
                    height: 80.h,
                    child: Image.asset(_switchImage(widget.items[0])),
                  )
                ],
              ),
              AppSpacer(height: 24.h),
              MovieList(
                items: widget.items,
                backgroundColor: Colors.white,
              ),
              ActionButton(
                name: Strings.backButton,
                textColor: AppColors.baseColor,
                backgroundColor: AppColors.white,
                handleTap: toHome,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

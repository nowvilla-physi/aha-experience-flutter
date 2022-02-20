import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class Movies extends StatefulWidget {
  const Movies({
    Key? key,
    required this.title,
    required this.level,
  }) : super(key: key);
  final String title;
  final String level;

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

  @override
  Widget build(BuildContext context) {
    final List<DataItem> items =
        ModalRoute.of(context)?.settings.arguments as List<DataItem>;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
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
                    child: Image.asset(_switchImage(items[0])),
                  )
                ],
              ),
              AppSpacer(height: 24.h),
              Flexible(
                child: MovieList(
                  items: items,
                  backgroundColor: Colors.white,
                ),
              )
            ])),
      ),
    );
  }
}

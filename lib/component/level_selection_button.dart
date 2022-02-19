import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class LevelSelectionButton extends StatelessWidget {
  const LevelSelectionButton(
      {Key? key,
      required this.name,
      required this.backgroundColor,
      required this.handleTap})
      : super(key: key);
  final String name;
  final Color backgroundColor;
  final Function handleTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        child: Text(
          name,
          style: TextStyle(fontSize: 20.sp),
        ),
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.allBorderRadius),
          ),
        ),
        onPressed: () => handleTap(),
      ),
    );
  }
}

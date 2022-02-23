import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

/// アクションボタン
///
/// 指定したアクションによって、そのアクションを実行する。
/// ボタン名称[name]、背景色[backgroundColor]、文字色[textColor]、タップイベント[handleTap]を受け取る。
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
    required this.handleTap,
  }) : super(key: key);
  final String name;
  final Color backgroundColor;
  final Color textColor;
  final Function handleTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      height: 48.h,
      child: ElevatedButton(
        child: Text(
          name,
          style: TextStyle(fontSize: 18.sp),
        ),
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: () => handleTap(),
      ),
    );
  }
}

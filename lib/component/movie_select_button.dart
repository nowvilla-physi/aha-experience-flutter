import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

/// ムービー選択ボタン
///
/// 選択するとムービー再生画面に遷移する。
/// データのアイテム[item]、、タップイベント[handleTap]を受け取る。
class MovieSelectButton extends StatefulWidget {
  const MovieSelectButton(
      {Key? key, required this.item, required this.handleTap})
      : super(key: key);
  final DataItem item;
  final Function handleTap;

  @override
  State<MovieSelectButton> createState() => _MovieSelectButtonState();
}

class _MovieSelectButtonState extends State<MovieSelectButton> {
  String _createButtonName(DataItem item) {
    final filledZeroId = "${item.id}".padLeft(2, "0");
    return item.isLocked ? Strings.locked : "Aha Film #$filledZeroId";
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Column(children: <Widget>[
      AppSpacer(height: Dimens.movieItemMarginVertical.h),
      SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          child: Text(
            _createButtonName(item),
            style: TextStyle(fontSize: 18.sp),
          ),
          style: ElevatedButton.styleFrom(
            primary: AppColors.beginner,
            onPrimary: AppColors.white,
            onSurface: AppColors.disabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.allBorderRadius),
            ),
          ),
          onPressed: item.isLocked ? null : () => widget.handleTap(),
        ),
      ),
      AppSpacer(height: Dimens.movieItemMarginVertical.h),
    ]);
  }
}

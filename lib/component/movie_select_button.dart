import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

/// ムービー選択ボタン
///
/// タップするとムービー再生画面に遷移する。
/// データのアイテム[item]を受け取る。
class MovieSelectButton extends ConsumerWidget {
  const MovieSelectButton({Key? key, required this.item}) : super(key: key);
  final DataItem item;

  String _createButtonName(DataItem item) {
    final filledZeroId = "${item.id}".padLeft(2, "0");
    return item.isLocked ? Strings.locked : "Aha Film #$filledZeroId";
  }

  Color _switchBackgroundColor(DataItem item) {
    switch (item.level) {
      case "beginner":
        return AppColors.beginner;
      case "advanced":
        return AppColors.advanced;
      case "demon":
        return AppColors.demon;
      default:
        return AppColors.beginner;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: <Widget>[
      SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          child: Text(
            _createButtonName(item),
            style: TextStyle(fontSize: 20.sp),
          ),
          style: ElevatedButton.styleFrom(
            primary: _switchBackgroundColor(item),
            onPrimary: AppColors.white,
            onSurface: AppColors.disabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.allBorderRadius),
            ),
          ),
          onPressed: item.isLocked
              ? null
              : () => Navigator.pushNamed(
                    context,
                    Strings.moviePlayerPath,
                    arguments: MoviePlayerArguments(item, ref),
                  ),
        ),
      ),
      AppSpacer(height: Dimens.movieItemMarginVertical.h),
    ]);
  }
}

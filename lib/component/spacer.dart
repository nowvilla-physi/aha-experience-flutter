import 'dart:core';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:aha_experience/importer.dart';

/// marginやpaddingの役割をするスペーサー
///
/// 指定した高さ[height]の分だけ余白を取る。
/// 横幅は画面いっぱいの幅とする。
class AppSpacer extends SizedBox {
  const AppSpacer({Key? key, required double height})
      : super(key: key, height: height, width: double.infinity);
}

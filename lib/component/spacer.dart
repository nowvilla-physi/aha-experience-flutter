import 'dart:core';

import 'package:flutter/cupertino.dart';

class AppSpacer extends SizedBox {
  const AppSpacer({Key? key, double height = 16})
      : super(key: key, height: height, width: double.infinity);
}

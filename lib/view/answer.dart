import 'package:flutter/material.dart';
import 'package:aha_experience/importer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Answer extends StatelessWidget {
  const Answer({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.allPadding.w,
            vertical: Dimens.allPadding.h,
          ),
          child: Column(
            children: <Widget>[
              Text("")
            ],
          ),
        ),
      ),
    );
  }
}

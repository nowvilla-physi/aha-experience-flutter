import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void appPrint() {
    debugPrint("clicked!!");
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/home-logo.png"),
              AppSpacer(height: 64.h),
              LevelSelectionButton(
                key: const Key(Strings.beginnerButton),
                name: Strings.beginnerButton,
                handleTap: appPrint,
                backgroundColor: AppColors.beginner,
              ),
              AppSpacer(height: 24.h),
              LevelSelectionButton(
                key: const Key(Strings.advancedButton),
                name: Strings.advancedButton,
                handleTap: appPrint,
                backgroundColor: AppColors.advanced,
              ),
              AppSpacer(height: 24.h),
              LevelSelectionButton(
                key: const Key(Strings.demonButton),
                name: Strings.demonButton,
                handleTap: appPrint,
                backgroundColor: AppColors.demon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

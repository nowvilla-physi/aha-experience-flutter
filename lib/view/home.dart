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
              const AppSpacer(height: 64),
              LevelSelectionButton(
                  name: Strings.beginnerButton,
                  handleTap: appPrint,
                  backgroundColor: AppColors.beginner,
              ),
              const AppSpacer(height: 24),
              LevelSelectionButton(
                name: Strings.advancedButton,
                handleTap: appPrint,
                backgroundColor: AppColors.advanced,
              ),
              const AppSpacer(height: 24),
              LevelSelectionButton(
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

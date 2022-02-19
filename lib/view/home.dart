import 'package:aha_experience/resource/colors.dart';
import 'package:aha_experience/resource/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              const Text(
                'You have pushed the button this many times:',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

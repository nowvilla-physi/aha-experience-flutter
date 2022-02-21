import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class MoviePlayer extends StatefulWidget {
  const MoviePlayer({Key? key}) : super(key: key);

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  String _createButtonName(DataItem item) {
    final filledZeroId = "${item.id}".padLeft(2, "0");
    return item.isLocked ? Strings.locked : "Aha Film #$filledZeroId";
  }

  @override
  Widget build(BuildContext context) {
    final DataItem item =
        ModalRoute.of(context)?.settings.arguments as DataItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(_createButtonName(item)),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.allPadding.w,
            vertical: Dimens.allPadding.h,
          ),
          child: Column(
            children: <Widget>[
              Text(
                _createButtonName(item),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28.sp,
                ),
              ),
              Image.asset("assets/images/home-logo.png"),
            ],
          ),
        ),
      ),
    );
  }
}

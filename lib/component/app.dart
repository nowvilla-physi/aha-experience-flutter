import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:
            const Size(Dimens.iPhone13ProWidth, Dimens.iPhone13ProHeight),
        builder: () {
          return MaterialApp(
            title: Strings.appTitle,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.mainColor,
              ),
              scaffoldBackgroundColor: AppColors.baseColor,
            ),
            home: const Home(title: Strings.appTitle),
          );
        });
  }
}

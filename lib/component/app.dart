import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

// This widget is the root of your application.
class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppRouter(ref: ref);
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
              routes: router.createConfig(),
              onGenerateRoute: (RouteSettings settings) =>
                  router.createGenerateRoute(settings));
        });
  }
}

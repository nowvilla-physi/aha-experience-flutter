import 'package:flutter/cupertino.dart';
import 'package:aha_experience/importer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリのルーター
///
/// アプリの画面遷移の定義を行う。
/// 指定されたパスに対してpushNamed("path")をすると指定した画面に遷移する。
class AppRouter {
  WidgetRef ref;

  AppRouter({required this.ref});

  Map<String, Widget Function(BuildContext)> createConfig() {
    return {
      Strings.homePath: (BuildContext context) => const Home(
            key: Key(Strings.appTitle),
            title: Strings.appTitle,
          ),
      Strings.beginnerMoviesPath: (BuildContext context) => Movies(
            key: const Key(Strings.beginnerMoviesPath),
            level: Strings.beginner,
            title: Strings.beginnerMoviesTitle,
            items: ref.watch(beginnerDataItemsProvider.notifier).state,
          ),
      Strings.advancedMoviesPath: (BuildContext context) => Movies(
            key: const Key(Strings.advancedMoviesPath),
            level: Strings.advanced,
            title: Strings.advancedMoviesTitle,
            items: ref.watch(advancedDataItemsProvider.notifier).state,
          ),
      Strings.demonMoviesPath: (BuildContext context) => Movies(
            key: const Key(Strings.demonMoviesPath),
            level: Strings.demon,
            title: Strings.demonMoviesTitle,
            items: ref.watch(demonDataItemsProvider.notifier).state,
          ),
    };
  }

  MaterialPageRoute? createGenerateRoute(RouteSettings settings) {
    if (settings.name == Strings.moviePlayerPath) {
      final args = settings.arguments as MoviePlayerArguments;
      return MaterialPageRoute(
        builder: (context) {
          return MoviePlayer(
            item: args.item,
            ref: args.ref,
          );
        },
      );
    } else if (settings.name == Strings.answerPath) {
      final args = settings.arguments as DataItem;
      return MaterialPageRoute(
        builder: (context) {
          return Answer(
            item: args,
            title: Strings.answerTitle,
          );
        },
      );
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}

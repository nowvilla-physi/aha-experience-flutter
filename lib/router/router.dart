import 'package:flutter/cupertino.dart';
import 'package:aha_experience/importer.dart';

/// アプリのルーター
///
/// アプリの画面遷移の定義を行う。
/// 指定されたパスに対してpushNamed("path")をすると指定した画面に遷移する。
class AppRouter {
  final Map<String, Widget Function(BuildContext)> config = {
    Strings.homePath: (BuildContext context) => const Home(
          key: Key(Strings.appTitle),
          title: Strings.appTitle,
        ),
    Strings.beginnerMoviesPath: (BuildContext context) => const Movies(
        key: Key(Strings.beginnerMoviesPath),
        level: Strings.beginner,
        title: Strings.beginnerMoviesTitle),
    Strings.advancedMoviesPath: (BuildContext context) => const Movies(
        key: Key(Strings.advancedMoviesPath),
        level: Strings.advanced,
        title: Strings.advancedMoviesTitle),
    Strings.demonMoviesPath: (BuildContext context) => const Movies(
        key: Key(Strings.demonMoviesPath),
        level: Strings.demon,
        title: Strings.demonMoviesTitle),
    Strings.moviePlayerPath: (BuildContext context) => const MoviePlayer(),
    // TODO 遷移画面を変更する
    Strings.answerPath: (BuildContext context) => const Home(
          title: '2w3',
        ),
  };
}

import 'package:flutter/material.dart';
import 'package:aha_experience/importer.dart';

/// レベル選択ボタン
///
/// 選択すると動画一覧画面に遷移する。
/// ボタン名称[name]、背景色[backgroundColor]、タップイベント[handleTap]を受け取る。
class MovieList extends StatelessWidget {
  const MovieList({
    Key? key,
    required this.items,
    required this.backgroundColor,
  }) : super(key: key);

  final List<DataItem> items;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return MovieSelectButton(item: items[index]);
      },
      itemCount: items.length,
    );
  }
}

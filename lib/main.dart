import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:aha_experience/importer.dart';

void main() async {
  // 向きを縦に固定する
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 広告の初期化
  MobileAds.instance.initialize();

  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  ));

  // envファイルの読みこみ
  await dotenv.load(fileName: ".env");

  // ローカルデータの読み込み
  final cache = Cache();
  final savedData = await cache.read();
  final List<DataItem> dataItems = savedData ?? await _loadDataItemsFromJson();
  final List<DataItem> beginnerDataItems =
      _filterEachLevel(dataItems, "beginner");
  final List<DataItem> advancedDataItems =
      _filterEachLevel(dataItems, "advanced");
  final List<DataItem> demonDataItems = _filterEachLevel(dataItems, "demon");

  runApp(ProviderScope(overrides: [
    dataItemsProvider.overrideWithProvider(StateProvider((ref) => dataItems)),
    beginnerDataItemsProvider
        .overrideWithProvider(StateProvider((ref) => beginnerDataItems)),
    advancedDataItemsProvider
        .overrideWithProvider(StateProvider((ref) => advancedDataItems)),
    demonDataItemsProvider
        .overrideWithProvider(StateProvider((ref) => demonDataItems)),
  ], child: const App()));
}

Future<List<DataItem>> _loadDataItemsFromJson() async {
  String jsonStr = await rootBundle.loadString("assets/json/data.json");
  final data = json.decode(jsonStr)["data"];
  return List<DataItem>.from(data
      .map((value) => DataItem.fromJson(Map<String, dynamic>.from(value)))
      .toList());
}

List<DataItem> _filterEachLevel(List<DataItem> data, String level) {
  return data.where((item) => item.level == level).toList();
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aha_experience/importer.dart';

int count() {
  return 1;
}

void main() async {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  ));

  final List<DataItem> dataItems = await _loadDataItemsFromJson();
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

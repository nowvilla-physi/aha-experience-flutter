import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aha_experience/importer.dart';

class Cache {
  static final Cache _cache = Cache._internal();
  static const _key = "cacheKey";
  static const _dataKey = "data";

  factory Cache() => _cache;

  Cache._internal();

  Future<List<DataItem>?> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr != null) {
      final List<dynamic> data = json.decode(jsonStr)[_dataKey];
      return data.map((item) => DataItem.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  Future<void> savedData(List<DataItem> items) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode({_dataKey: items});
    prefs.setString(_key, jsonStr);
  }
}

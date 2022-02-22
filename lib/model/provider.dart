import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateProvider((ref) => 0);
final dataItemsProvider = StateProvider((ref) => []);
final beginnerDataItemsProvider = StateProvider((ref) => []);
final advancedDataItemsProvider = StateProvider((ref) => []);
final demonDataItemsProvider = StateProvider((ref) => []);

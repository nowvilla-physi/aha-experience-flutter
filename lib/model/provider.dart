import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aha_experience/importer.dart';

final dataItemsProvider = StateProvider((ref) => [] as List<DataItem>);
final beginnerDataItemsProvider = StateProvider((ref) => [] as List<DataItem>);
final advancedDataItemsProvider = StateProvider((ref) => [] as List<DataItem>);
final demonDataItemsProvider = StateProvider((ref) => [] as List<DataItem>);

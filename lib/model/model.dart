import 'package:aha_experience/importer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataItem {
  int id;
  String level;
  bool isLocked;
  bool isLastOfLevel;
  String hint;
  String answer;

  DataItem(this.id, this.level, this.isLocked, this.isLastOfLevel, this.hint,
      this.answer);

  DataItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        level = json['level'],
        isLocked = json['isLocked'],
        isLastOfLevel = json['isLastOfLevel'],
        hint = json['hint'],
        answer = json['answer'];

  @override
  int get hashCode =>
      id.hashCode ^
      level.hashCode ^
      isLocked.hashCode ^
      isLastOfLevel.hashCode ^
      hint.hashCode ^
      answer.hashCode;

  @override
  bool operator ==(Object other) {
    return other is DataItem &&
        id == other.id &&
        level == other.level &&
        isLocked == other.isLocked &&
        isLastOfLevel == other.isLastOfLevel &&
        hint == other.hint &&
        answer == other.answer;
  }

  @override
  String toString() {
    return "$id, $level, $isLocked, $isLastOfLevel, $hint, $answer";
  }
}

class MoviePlayerArguments {
  DataItem item;
  WidgetRef ref;

  MoviePlayerArguments(this.item, this.ref);

  @override
  int get hashCode => item.hashCode ^ ref.hashCode;

  @override
  bool operator ==(Object other) {
    return other is MoviePlayerArguments &&
        item == other.item &&
        ref == other.ref;
  }

  @override
  String toString() => "$item, $ref";
}

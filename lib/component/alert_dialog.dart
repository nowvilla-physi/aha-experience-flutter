import 'package:flutter/material.dart';
import 'package:aha_experience/importer.dart';

class AppAlertDialog {
  const AppAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.context,
    this.handleClick,
    this.positiveName,
    this.negativeName,
  });

  final String title;
  final String content;
  final BuildContext context;
  final Function? handleClick;
  final String? positiveName;
  final String? negativeName;

  void _dismiss() {
    Navigator.pop(context);
  }

  void _onClick() {
    _dismiss();
    if (handleClick != null) {
      handleClick!();
    }
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(negativeName ?? Strings.cancel),
              onPressed: () => _dismiss(),
            ),
            TextButton(
              child: Text(positiveName ?? Strings.ok),
              onPressed: () => _onClick(),
            ),
          ],
        );
      },
    );
  }
}

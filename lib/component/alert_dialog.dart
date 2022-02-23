import 'package:flutter/material.dart';
import 'package:aha_experience/importer.dart';

class AppAlertDialog {
  const AppAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.handleClick,
      required this.context});

  final String title;
  final String content;
  final Function handleClick;
  final BuildContext context;

  void _dismiss() {
    Navigator.pop(context);
  }

  void _onClick() {
    _dismiss();
    handleClick();
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
              child: const Text(Strings.cancel),
              onPressed: () => _dismiss(),
            ),
            TextButton(
              child: const Text(Strings.ok),
              onPressed: () => _onClick(),
            ),
          ],
        );
      },
    );
  }
}

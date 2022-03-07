import 'package:flutter/material.dart';
import 'package:aha_experience/importer.dart';

class OverlayLoading extends StatelessWidget {
  const OverlayLoading({Key? key, required this.visible}) : super(key: key);
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            decoration: const BoxDecoration(color: AppColors.baseColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.mainColor))
              ],
            ),
          )
        : Container();
  }
}

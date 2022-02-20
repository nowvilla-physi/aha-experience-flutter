import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aha_experience/importer.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DataItem> _beginnerDataItems = [];
  List<DataItem> _advancedDataItems = [];
  List<DataItem> _demonDataItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _loadDataItemsFromJson();
    });
  }

  Future<void> _loadDataItemsFromJson() async {
    String jsonStr = await rootBundle.loadString("assets/json/data.json");
    final data = json.decode(jsonStr)["data"];
    final dataItems = List<DataItem>.from(data
        .map((value) => DataItem.fromJson(Map<String, dynamic>.from(value)))
        .toList());
    _beginnerDataItems = _filterEachLevel(dataItems, "beginner");
    _advancedDataItems = _filterEachLevel(dataItems, "advanced");
    _demonDataItems = _filterEachLevel(dataItems, "demon");
  }

  List<DataItem> _filterEachLevel(List<DataItem> data, String level) {
    return data.where((item) => item.level == level).toList();
  }

  void toBeginnerMovies() {
    Navigator.pushNamed(
      context,
      Strings.beginnerMoviesPath,
      arguments: _beginnerDataItems,
    );
  }

  void toAdvancedMovies() {
    Navigator.pushNamed(
      context,
      Strings.advancedMoviesPath,
      arguments: _advancedDataItems,
    );
  }

  void toDemonMovies() {
    Navigator.pushNamed(
      context,
      Strings.demonMoviesPath,
      arguments: _demonDataItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.allPadding.w,
            vertical: Dimens.allPadding.h,
          ),
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/home-logo.png"),
              AppSpacer(height: 64.h),
              LevelSelectionButton(
                key: const Key(Strings.beginnerButton),
                name: Strings.beginnerButton,
                handleTap: toBeginnerMovies,
                backgroundColor: AppColors.beginner,
              ),
              AppSpacer(height: 24.h),
              LevelSelectionButton(
                key: const Key(Strings.advancedButton),
                name: Strings.advancedButton,
                handleTap: toAdvancedMovies,
                backgroundColor: AppColors.advanced,
              ),
              AppSpacer(height: 24.h),
              LevelSelectionButton(
                key: const Key(Strings.demonButton),
                name: Strings.demonButton,
                handleTap: toDemonMovies,
                backgroundColor: AppColors.demon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

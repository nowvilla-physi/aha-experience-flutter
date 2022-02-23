import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:aha_experience/importer.dart';

class MoviePlayer extends StatefulWidget {
  MoviePlayer({Key? key, required this.item}) : super(key: key);
  DataItem item;

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  late VideoPlayerController _controller;
  bool _isLoading = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/movies/aha${widget.item.id}.mp4");
    _controller.initialize().then((_) {
      setState(() {});

      _controller.addListener(() {
        final value = _controller.value;
        if (!value.isPlaying &&
            value.position.inSeconds >= value.duration.inSeconds) {
          setState(() {
            _isFinished = true;
          });
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _createButtonName(DataItem item) {
    final filledZeroId = "${item.id}".padLeft(2, "0");
    return item.isLocked ? Strings.locked : "Aha Film #$filledZeroId";
  }

  void playMovie() async {
    // ムービー再生が終わった場合
    final value = _controller.value;
    if (!value.isPlaying &&
        value.position.inSeconds >= value.duration.inSeconds) {
      setState(() {
        _isLoading = true;
      });
      _controller.initialize();
      _controller.seekTo(Duration.zero).then((_) => _controller.pause());
      await Future.delayed(const Duration(milliseconds: 2000), () {});
      setState(() {
        _isFinished = false;
        _isLoading = false;
      });
      // ムービーが再生中でない場合
    } else if (!value.isPlaying) {
      _controller.seekTo(Duration.zero).then((_) => _controller.play());
    } else {
      // nop
    }
  }

  void toAnswer() {
    Navigator.of(context).pushNamed(Strings.answerPath);
  }

  void toMovieList() {
    switch (widget.item.level) {
      case "beginner":
        Navigator.of(context).pushNamed(Strings.beginnerMoviesPath);
        break;
      case "advanced":
        Navigator.of(context).pushNamed(Strings.advancedMoviesPath);
        break;
      case "demon":
        Navigator.of(context).pushNamed(Strings.demonMoviesPath);
        break;
      default:
        Navigator.of(context).pushNamed(Strings.beginnerMoviesPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_createButtonName(widget.item)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: Dimens.allPadding.h,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    _createButtonName(widget.item),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 28.sp,
                    ),
                  ),
                  AppSpacer(height: 16.h),
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                  ),
                  AppSpacer(height: 48.h),
                  ActionButton(
                    name:
                        _isFinished ? Strings.retryButton : Strings.playButton,
                    textColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                    handleTap: playMovie,
                  ),
                  AppSpacer(height: 16.h),
                  ActionButton(
                    name: Strings.answerButton,
                    textColor: AppColors.white,
                    backgroundColor: AppColors.answer,
                    handleTap: toAnswer,
                  ),
                  AppSpacer(height: 16.h),
                  ActionButton(
                    name: Strings.backButton,
                    textColor: AppColors.baseColor,
                    backgroundColor: AppColors.white,
                    handleTap: toMovieList,
                  ),
                ],
              ),
            ),
          ),
          OverlayLoading(visible: _isLoading),
        ],
      ),
    );
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:aha_experience/importer.dart';

class MoviePlayer extends StatefulWidget {
  MoviePlayer({
    Key? key,
    required this.item,
    required this.ref,
  }) : super(key: key);
  DataItem item;
  WidgetRef ref;

  @override
  _MoviePlayerState createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  VideoPlayerController? _controller;
  bool _isLoading = false;
  bool _isFinished = false;
  late final AdReward adReward;
  late final AdReward adRewardForAnswer;

  @override
  void initState() {
    super.initState();
    // movie_playerの初期化
    Future(() async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref("movies/aha${widget.item.id}.mp4");
      final url = await ref.getDownloadURL();

      _controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        });

      _controller?.addListener(() {
        final value = _controller?.value;
        if (value != null) {
          if (!value.isPlaying &&
              value.position.inSeconds >= value.duration.inSeconds) {
            setState(() {
              _isFinished = true;
            });
          }
        }
      });
    });

    // reward広告の初期化
    // adReward = AdReward(handleWatchAd: _showHint);
    // adRewardForAnswer = AdReward(handleWatchAd: _toAnswer);
    // adReward.createRewardedAd();
    // adRewardForAnswer.createRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _controller = null;
  }

  String _createButtonName(DataItem item) {
    final filledZeroId = "${item.id}".padLeft(2, "0");
    return item.isLocked ? Strings.locked : "Aha Film #$filledZeroId";
  }

  void _playMovie() async {
    // ムービー再生が終わった場合
    final value = _controller?.value;
    if (value == null) {
      return;
    }
    if (!value.isPlaying &&
        value.position.inSeconds >= value.duration.inSeconds) {
      setState(() {
        _isLoading = true;
      });
      _initializeMoviePlayer();
      await Future.delayed(const Duration(milliseconds: 2000), () {});
      setState(() {
        _isFinished = false;
        _isLoading = false;
      });
      // ムービーが再生中でない場合
    } else if (!value.isPlaying) {
      _controller?.seekTo(Duration.zero).then((_) => _controller?.play());
    } else {
      // nop
    }
  }

  void _showAnswerDialog() {
    // AppAlertDialog(
    //   title: Strings.watchAnswerTitle,
    //   content: Strings.watchAnswerContent,
    //   handleClick: _showRewardedAdForAnswer,
    //   context: context,
    // ).showAlertDialog();
    AppAlertDialog(
      title: Strings.watchAnswerTitle,
      content: Strings.watchAnswerContent,
      handleClick: _toAnswer,
      context: context,
    ).showAlertDialog();
  }

  // void _showRewardedAdForAnswer() {
  //   if (widget.item.id % 2 == 0) {
  //     adRewardForAnswer.showRewardedAd();
  //   } else {
  //     _toAnswer();
  //   }
  // }

  void _toAnswer() {
    final id = widget.item.id;
    final ref = widget.ref;
    if (id > 0 && id < 38) {
      final nextId = id + 1;
      final dataItems = ref.read(dataItemsProvider.notifier).state;
      final nextDataItem = dataItems.firstWhere((item) => item.id == nextId);
      nextDataItem.isLocked = false;
      final newData = dataItems
          .map((item) => item.id == nextId ? nextDataItem : item)
          .toList();
      ref.read(dataItemsProvider.notifier).state = newData;
      Cache().savedData(newData);
    }
    Navigator.pushNamed(context, Strings.answerPath, arguments: widget.item);
    _initializeMoviePlayer();
    _controller?.dispose();
    _controller = null;
  }

  void _showHintDialog() {
    // AppAlertDialog(
    //   title: Strings.watchHintTitle,
    //   content: Strings.watchHintContent,
    //   handleClick: _showRewardedAd,
    //   context: context,
    // ).showAlertDialog();
    AppAlertDialog(
      title: Strings.watchHintTitle,
      content: Strings.watchHintContent,
      handleClick: _showHint,
      context: context,
    ).showAlertDialog();
  }

  // void _showRewardedAd() {
  //   adReward.showRewardedAd();
  // }

  void _showHint() {
    AppAlertDialog(
      title: Strings.hintTitle,
      content: widget.item.hint,
      context: context,
      positiveName: Strings.close,
      negativeName: Strings.understand,
    ).showAlertDialog();
  }

  void _toMovieList() {
    Navigator.of(context).pop();
    _initializeMoviePlayer();
    _controller?.dispose();
    _controller = null;
  }

  void _initializeMoviePlayer() {
    _controller?.initialize();
    _controller?.seekTo(Duration.zero).then((_) => _controller?.pause());
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: Dimens.allMarginTop.h),
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
                      _controller!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                          : Container(),
                      VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: false,
                      ),
                      AppSpacer(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimens.actionButtonMarginHorizontal.w,
                            ),
                            child: ActionButton(
                              name: _isFinished
                                  ? Strings.retryButton
                                  : Strings.playButton,
                              textColor: AppColors.white,
                              backgroundColor: AppColors.blue,
                              handleTap: _playMovie,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimens.actionButtonMarginHorizontal.w,
                            ),
                            child: ActionButton(
                              name: Strings.hintButton,
                              textColor: AppColors.white,
                              backgroundColor: AppColors.orange,
                              handleTap: _showHintDialog,
                            ),
                          ),
                        ],
                      ),
                      AppSpacer(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimens.actionButtonMarginHorizontal.w,
                            ),
                            child: ActionButton(
                              name: Strings.answerButton,
                              textColor: AppColors.white,
                              backgroundColor: AppColors.answer,
                              handleTap: _showAnswerDialog,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimens.actionButtonMarginHorizontal.w,
                            ),
                            child: ActionButton(
                              name: Strings.backButton,
                              textColor: AppColors.baseColor,
                              backgroundColor: AppColors.white,
                              handleTap: _toMovieList,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            OverlayLoading(visible: _isLoading),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child:
              Column(mainAxisSize: MainAxisSize.min, children: const <Widget>[
            OverlayLoading(visible: true),
          ]),
        ),
      );
    }
  }
}

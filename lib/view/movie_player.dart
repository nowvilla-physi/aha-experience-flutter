import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:aha_experience/importer.dart';

class MoviePlayer extends StatefulWidget {
  const MoviePlayer({Key? key}) : super(key: key);

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  late VideoPlayerController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/movies/aha1.mp4');
    _controller.initialize().then((_) {
      setState(() {});
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
    if (_controller.value.isPlaying) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 2000), () {});
      setState(() {
        _isLoading = false;
      });
      _controller.seekTo(Duration.zero).then((_) => _controller.play());
    } else {
      _controller.seekTo(Duration.zero).then((_) => _controller.play());
    }
  }

  @override
  Widget build(BuildContext context) {
    final DataItem item =
        ModalRoute.of(context)?.settings.arguments as DataItem;

    return Scaffold(
        appBar: AppBar(
          title: Text(_createButtonName(item)),
        ),
        body: ClipRect(
          child: Stack(
            clipBehavior: Clip.hardEdge,
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
                        _createButtonName(item),
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
                      AppSpacer(height: 32.h),
                      ActionButton(
                        name: Strings.playButton,
                        textColor: AppColors.white,
                        backgroundColor: AppColors.orange,
                        handleTap: playMovie,
                      ),
                    ],
                  ),
                ),
              ),
              OverlayLoading(visible: _isLoading),
            ],
          ),
        ));
  }
}

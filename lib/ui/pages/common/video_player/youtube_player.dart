import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/ui/pages/common/expandable_text/expandable_text.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Homepage
class AppVideoPlayer extends StatefulWidget {
  ExerciseEntity exerciseEntity;
  AppVideoPlayer({
    Key? key,
    required this.exerciseEntity,
  }) : super(key: key);

  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: "sqTxfOChOJc",
          // YoutubePlayer.convertUrlToId(widget.exerciseEntity.videoLink) ?? "",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String timeAgo = "";
    if (widget.exerciseEntity.createdAt != null) {
      timeAgo = timeago.format(
        widget.exerciseEntity.createdAt ?? DateTime.now(),
        locale: 'vi',
      );
    }
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          _isPlayerReady = true;
        },
        topActions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 8,
              ),
              child: Image.asset(
                AppImages.icBack,
                color: AppColors.white,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
        onEnded: (data) {
          print('video ended');
        },
      ),
      builder: (context, player) => ListView(
        children: [
          player,
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      child: AppCacheImage(
                        url: widget.exerciseEntity.expertAvatar ?? "",
                        width: 40,
                        height: 40,
                        borderRadius: 20,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.exerciseEntity.title ?? "",
                          style: AppTextStyle.blackS16Bold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Dưỡng sinh chân pháp ${timeAgo.isNotEmpty ? " • $timeAgo" : ""}",
                          style: AppTextStyle.greyS14.copyWith(
                            color: AppColors.gray000000B3,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 74,
                          child: ExpandableText(
                            widget.exerciseEntity.desc ?? "",
                            trimLines: 3,
                            textStyle: AppTextStyle.greyS14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                _space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_return,
                            color: AppColors.main,
                            size: 45,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Trở về',
                            style: AppTextStyle.primaryS14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: AppColors.main,
                            size: 45,
                          ),
                          onPressed: _isPlayerReady
                              ? () {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Bắt đầu tập',
                            style: AppTextStyle.primaryS14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _space,
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: _getStateColor(_playerState),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _playerState.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);
}

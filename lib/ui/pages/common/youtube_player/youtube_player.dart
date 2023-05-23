import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/common/expandable_text/expandable_text.dart';
import 'package:ihz_bql/ui/pages/course/exercise_review/exercise_review_page.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';
import 'package:ihz_bql/utils/date_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:readmore/readmore.dart';

/// Homepage
class AppYoutubePlayer extends StatefulWidget {
  ExerciseEntity exerciseEntity;
  AppYoutubePlayer({
    Key? key,
    required this.exerciseEntity,
  }) : super(key: key);

  @override
  _AppYoutubePlayerState createState() => _AppYoutubePlayerState();
}

class _AppYoutubePlayerState extends State<AppYoutubePlayer> {
  late YoutubePlayerController _youtubeController;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late ValueNotifier<PlayerState> _playerState;

  bool _isPlayerReady = false;
  int practiceTime = 0;
  Timer? practiceTimer;
  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.exerciseEntity.videoLink) ?? "",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
      ),
    )..addListener(youtubeListener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _playerState = ValueNotifier<PlayerState>(PlayerState.unknown);
    _playerState.addListener(() {
      if (_playerState.value == PlayerState.playing) {
        inCreasePracticeTime();
      }
      if (_playerState.value == PlayerState.paused ||
          _playerState.value == PlayerState.buffering) {
        practiceTimer?.cancel();
      }
    });
  }

  void youtubeListener() {
    if (_isPlayerReady && mounted && !_youtubeController.value.isFullScreen) {
      setState(() {
        _playerState.value = _youtubeController.value.playerState;
      });
    }
  }

  void inCreasePracticeTime() {
    practiceTimer?.cancel();
    practiceTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        practiceTime = practiceTime + 1;
      });
    });
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _idController.dispose();
    _seekToController.dispose();
    practiceTimer?.cancel();
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
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.main,
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
          practiceTimer?.cancel();

          print('video ended');
        },
      ),
      builder: (context, player) => Stack(children: [
        Positioned(top: 0, left: 0, right: 0, child: player),
        Positioned(
          top: MediaQuery.of(context).size.width / 16 * 9,
          left: 0,
          right: 0,
          bottom: 0,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  left: 12,
                  right: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.exerciseEntity.title.toUpperCase(),
                              style: AppTextStyle.blackS16Bold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Visibility(
                              visible: widget
                                  .exerciseEntity.videoDuration.isNotEmpty,
                              child: Text(
                                "Thời lượng: ${widget.exerciseEntity.videoDuration} ${timeAgo.isNotEmpty ? " • $timeAgo" : ""}",
                                style: AppTextStyle.greyS14.copyWith(
                                  color: AppColors.gray000000B3,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: widget.exerciseEntity.desc.isNotEmpty,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 24,
                                    child: ReadMoreText(
                                      widget.exerciseEntity.desc,
                                      trimLines: 6,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: ' Hiện thêm',
                                      trimExpandedText: ' Ẩn bớt',
                                      moreStyle: AppTextStyle.primaryS14Bold,
                                      style: AppTextStyle.greyS14,
                                      lessStyle: AppTextStyle.primaryS14Bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: AppCacheImage(
                            url: widget.exerciseEntity.expertAvatar ?? "",
                            width: 40,
                            height: 40,
                            borderRadius: 20,
                          ),
                          margin: const EdgeInsets.only(
                            right: 10,
                            top: 10,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Text(
                            widget.exerciseEntity.expertName,
                            style: AppTextStyle.greyS14Bold.copyWith(
                              color: AppColors.gray000000B3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _getStateColor(_playerState.value),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          AppDateUtils.intToTimeLeft(practiceTime),
                          style: AppTextStyle.whiteS18Bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.keyboard_return,
                                color: _getStateColor(_playerState.value),
                                size: 45,
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Trở về',
                                style: AppTextStyle.primaryS14Regular.copyWith(
                                  color: _getStateColor(_playerState.value),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                _youtubeController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: _getStateColor(_playerState.value),
                                size: 45,
                              ),
                              onPressed: _isPlayerReady
                                  ? () {
                                      if (_youtubeController.value.isPlaying) {
                                        _youtubeController.pause();
                                        setState(() {});
                                      } else {
                                        _youtubeController.play();
                                      }
                                    }
                                  : null,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                _youtubeController.value.isPlaying
                                    ? 'Tạm dừng'
                                    : 'Bắt đầu tập',
                                style: AppTextStyle.primaryS14Regular.copyWith(
                                  color: _getStateColor(_playerState.value),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: practiceTime > 0,
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.done_all,
                                  color: _getStateColor(_playerState.value),
                                  size: 45,
                                ),
                                onPressed: practiceTime > 0
                                    ? () async {
                                        Application.router.navigateTo(
                                          context,
                                          Routes.exerciseReview,
                                        );
                                      }
                                    : null,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Kết thúc',
                                  style:
                                      AppTextStyle.primaryS14Regular.copyWith(
                                    color: _getStateColor(_playerState.value),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey;
      case PlayerState.unStarted:
        return Colors.grey;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return AppColors.main;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.grey;
      case PlayerState.cued:
        return Colors.blueAccent;
      default:
        return AppColors.main;
    }
  }

  Widget get _space => const SizedBox(height: 10);
}

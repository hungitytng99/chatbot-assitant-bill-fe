import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/exercise_entity.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class CourseItem extends StatefulWidget {
  ExerciseEntity exerciseEntity;
  CourseItem({
    Key? key,
    required this.exerciseEntity,
  }) : super(key: key);
  @override
  _CourseItemState createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                color: AppColors.black,
                width: double.infinity,
                height: 220,
                margin: const EdgeInsets.only(bottom: 8),
                child: AppCacheImage(url: widget.exerciseEntity.videoThumbnail ?? ""),
              ),
              Positioned(
                right: 6,
                bottom: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  child: Text(
                    widget.exerciseEntity.videoDuration ?? "",
                    style: AppTextStyle.whiteS14Regular,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(
                url: widget.exerciseEntity.expertAvatar ?? "",
                width: 40,
                height: 40,
                borderRadius: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    margin: const EdgeInsets.only(
                      top: 6,
                      left: 8,
                    ),
                    child: Text(
                      widget.exerciseEntity.title ?? "",
                      style: AppTextStyle.blackS14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    margin: const EdgeInsets.only(
                      top: 4,
                      left: 8,
                    ),
                    child: Text(
                      "${widget.exerciseEntity.expertName} ${timeAgo.isNotEmpty ? " • $timeAgo" : ""}",
                      style: AppTextStyle.greyS14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/daily_actions_entity.dart';
import 'package:ihz_bql/utils/date_utils.dart';

class DiaryPracticeItem extends StatefulWidget {
  final DailyActionEntity? dailyAction;
  const DiaryPracticeItem({
    Key? key,
    required this.dailyAction,
  }) : super(key: key);
  @override
  _DiaryPracticeItemState createState() => _DiaryPracticeItemState();
}

class _DiaryPracticeItemState extends State<DiaryPracticeItem> {
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
    String practiceDuration = "0";
    try {
      practiceDuration = AppDateUtils.intToTimeLeft(
        int.parse(widget.dailyAction?.practiceDuration ?? "0"),
      );
    } catch (e) {
      practiceDuration = widget.dailyAction?.practiceDuration ?? "0";
    }
    return InkWell(
      onTap: () {
        print('tap');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          top: 15,
          right: 12,
          left: 15,
          // bottom: 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Bài tập: ",
                      style: AppTextStyle.blackS14Bold,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 7 / 16,
                      child: Text(
                        widget.dailyAction?.exerciseName ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Thời gian tập: ",
                      style: AppTextStyle.blackS14Bold,
                    ),
                    Text(
                      practiceDuration,
                    ),
                  ],
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  Image.asset(
                    AppImages.icClock,
                    width: 20,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${AppDateUtils.getHourAndMinutes(widget.dailyAction?.startedAt)} - ${AppDateUtils.getHourAndMinutes(widget.dailyAction?.endedAt)}",
                    style: AppTextStyle.blackS14Bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

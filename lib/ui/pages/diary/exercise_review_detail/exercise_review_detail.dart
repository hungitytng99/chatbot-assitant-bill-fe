import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/entities/daily_actions_entity.dart';
import 'package:ihz_bql/models/enums/exercise_review_type.dart';
import 'package:ihz_bql/models/enums/review_star_type.dart';

class ExerciseReviewDetail extends StatefulWidget {
  final DailyActionEntity? dailyAction;

  const ExerciseReviewDetail({
    Key? key,
    required this.dailyAction,
  }) : super(key: key);
  @override
  _ExerciseReviewDetailState createState() => _ExerciseReviewDetailState();
}

class _ExerciseReviewDetailState extends State<ExerciseReviewDetail> {
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.only(
            top: 8,
            left: 12,
            right: 12,
            bottom: 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đánh giá của bạn',
                    style: AppTextStyle.blackS18W800.copyWith(
                      fontSize: 26,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              _buildStarReview(
                title: "Đánh giá về tâm trí",
                description: 'Bạn cảm thấy tâm trí sáng suốt như nào?',
                type: ReviewStarType.reviewMind,
                initialRating:
                    double.parse(widget.dailyAction?.mindRate ?? "5.0"),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildStarReview(
                title: "Đánh giá về cơ thể",
                description: 'Bạn cảm thấy cơ thể linh hoạt như nào?',
                type: ReviewStarType.reviewBody,
                initialRating:
                    double.parse(widget.dailyAction?.bodyRate ?? "5.0"),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildYesNoReview(
                title: "Đánh giá bài tập",
                description: 'Bạn cảm thấy thích bài tập này không?',
              ),
              const SizedBox(
                height: 15,
              ),
              _buildPracticeReview(
                title: "Đánh giá sự luyện tập",
                description: 'Diễn tả cảm nhận tự luyện tập hôm nay',
              ),
              const SizedBox(
                height: 15,
              ),
              _buildShareMoreReview(
                title: "Chia sẻ nhiều hơn",
                description:
                    'Nhật ký luyện tập giúp bạn nhìn thấy tình hình luyện tập qua mỗi ngày',
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarReview({
    String title = "",
    String description = "",
    double initialRating = 5,
    required ReviewStarType type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.blackS18W600.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              "*",
              style: AppTextStyle.redS16Bold,
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          description,
          style: AppTextStyle.greyS14W500,
        ),
        const SizedBox(
          height: 6,
        ),
        RatingBar.builder(
          ignoreGestures: true,
          initialRating: initialRating,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          maxRating: 5,
          itemSize: 50,
          glowColor: AppColors.main,
          unratedColor: AppColors.grey,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
      ],
    );
  }

  ExerciseReviewEnum selectExerciseReview = ExerciseReviewEnum.good;
  Widget _buildYesNoReview({
    String title = "",
    String description = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.blackS18W600.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              "*",
              style: AppTextStyle.redS16Bold,
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          description,
          style: AppTextStyle.greyS14W500,
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            ...ExerciseReviewEnum.values
                .map((ExerciseReviewEnum exerciseReview) {
              return _buildRatingButton(
                icon: ExerciseReviewExtension.getFromString(
                                widget.dailyAction?.exerciseRate)
                            .value ==
                        exerciseReview.value
                    ? exerciseReview.activeIcon
                    : exerciseReview.deActiveIcon,
                title: exerciseReview.title,
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingButton({
    required Icon icon,
    String title = "",
  }) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: AppTextStyle.blackS16W600,
        ),
      ],
    );
  }

  Widget _buildPracticeReview({
    String title = "",
    String description = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.blackS18W600.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              "*",
              style: AppTextStyle.redS16Bold,
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          description,
          style: AppTextStyle.greyS14W500,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: [
            for (int i = 0;
                i < (widget.dailyAction?.keywordDesc ?? []).length;
                i++) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                margin: const EdgeInsets.only(right: 10, bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors.main),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: AppColors.primaryLighter,
                ),
                child: Text(widget.dailyAction?.keywordDesc![i] ?? ""),
              )
            ]
          ],
        ),
      ],
    );
  }

  Widget _buildShareMoreReview({
    String title = "",
    String description = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.blackS18W600.copyWith(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          description,
          style: AppTextStyle.greyS14W500,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(widget.dailyAction?.note ?? "Bạn không để lại cảm nhận nào"),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

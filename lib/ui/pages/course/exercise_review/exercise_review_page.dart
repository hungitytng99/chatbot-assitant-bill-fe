import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/enums/exercise_review_type.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/enums/review_star_type.dart';
import 'package:ihz_bql/models/params/feedback_exercise_body.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/course/exercise_review/exercise_review_cubit.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';
import 'package:ihz_bql/ui/widgets/commons/app_snackbar.dart';

class ExerciseReviewPage extends StatefulWidget {
  final String practiceId;
  final String exerciseId;
  final String exerciseName;

  ExerciseReviewPage({
    Key? key,
    required this.practiceId,
    required this.exerciseId,
    required this.exerciseName,
  }) : super(key: key);
  @override
  _ExerciseReviewPageState createState() => _ExerciseReviewPageState();
}

class _ExerciseReviewPageState extends State<ExerciseReviewPage> {
  late ExerciseReviewCubit exerciseReviewCubit;
  @override
  void initState() {
    exerciseReviewCubit = BlocProvider.of<ExerciseReviewCubit>(context);
    exerciseReviewCubit.getHashTags();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(Routes.home),
                      );
                    },
                    child: const Icon(
                      Icons.close,
                      size: 45,
                      color: AppColors.gray,
                    ),
                  ),
                  Text(
                    'Để lại đánh giá',
                    style: AppTextStyle.blackS18W800.copyWith(
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildStarReview(
                    title: "Đánh giá về tâm trí",
                    description: 'Mô tả gì đó',
                    type: ReviewStarType.reviewMind,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildStarReview(
                    title: "Đánh giá về cơ thể",
                    description: 'Mô tả gì đó',
                    type: ReviewStarType.reviewBody,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildYesNoReview(
                    title: "Đánh giá bài tập",
                    description: 'Mô tả gì đó',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildPracticeReview(
                    title: "Đánh giá sự luyện tập",
                    description: 'Mô tả gì đó',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildShareMoreReview(
                    title: "Chia sẻ nhiều hơn",
                    description: 'Mô tả gì đó',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "*Lưu ý: Những mục có dấu",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(" * ",
                          style: AppTextStyle.redS16Bold.copyWith(
                            fontStyle: FontStyle.italic,
                          )),
                      const Text(
                        "là bắt buộc phải chọn",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocConsumer<ExerciseReviewCubit, ExerciseReviewState>(
                      bloc: exerciseReviewCubit,
                      listener: (context, state) {
                        if (state.feedbackExerciseStatus ==
                            LoadStatus.success) {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Routes.home),
                          );
                          AppSnackbar.showInfo(
                            title: 'Thành công',
                            message:
                            'Cảm ơn bạn đã để lại đánh giá',
                          );
                          return;
                          return;
                        }

                        if (state.feedbackExerciseStatus ==
                            LoadStatus.failure) {
                          AppSnackbar.showError(
                            title: 'Lỗi',
                            message:
                                'Một lỗi đã xảy ra khi ghi nhận đánh giá của bạn',
                          );
                          return;
                        }
                      },
                      buildWhen: (prev, cur) {
                        return prev.feedbackExerciseStatus !=
                            cur.feedbackExerciseStatus;
                      },
                      builder: (context, state) {
                        return AppButton(
                          title: "Gửi đánh giá".toUpperCase(),
                          textStyle: AppTextStyle.whiteS14Bold.copyWith(
                            fontSize: 16,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          isLoading: state.feedbackExerciseStatus ==
                              LoadStatus.loading,
                          isEnable: selectedKeywords.isNotEmpty,
                          onPressed: () {
                            // _appCubit.logout();
                            exerciseReviewCubit.feedbackExercise(
                              body: FeedbackExerciseBody(
                                practiceId: widget.practiceId,
                                exerciseId: widget.exerciseId,
                                exerciseName: widget.exerciseName,
                                mindRate: reviewMindStar.toString(),
                                bodyRate: reviewBodyStar.toString(),
                                exerciseRate: selectExerciseReview.title,
                                keywordDesc: selectedKeywords,
                              ),
                            );
                          },
                          disableBackgroundColor: AppColors.textGray,
                        );
                      }),
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double reviewMindStar = 5;
  double reviewBodyStar = 5;
  Widget _buildStarReview({
    String title = "",
    String description = "",
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
          initialRating: 5,
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
          onRatingUpdate: (rating) {
            if (type == ReviewStarType.reviewMind) {
              reviewMindStar = rating;
            }

            if (type == ReviewStarType.reviewBody) {
              reviewBodyStar = rating;
            }
          },
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
                icon: selectExerciseReview.value == exerciseReview.value
                    ? exerciseReview.activeIcon
                    : exerciseReview.deActiveIcon,
                title: exerciseReview.title,
                onPressed: () {
                  setState(() {
                    selectExerciseReview = exerciseReview;
                  });
                },
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingButton({
    required Icon icon,
    required void Function() onPressed,
    String title = "",
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
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
      ),
    );
  }

  List<String> selectedKeywords = [];
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
        BlocBuilder<ExerciseReviewCubit, ExerciseReviewState>(
          buildWhen: (prev, current) =>
              prev.getListReviewKeywordsStatus !=
              current.getListReviewKeywordsStatus,
          builder: (context, state) {
            return Wrap(
              children: [
                for (int i = 0;
                    i < (state.reviewKeywords?.keywords ?? []).length;
                    i++) ...[
                  GestureDetector(
                    onTap: () {
                      if (selectedKeywords.firstWhere(
                              (element) =>
                                  element == state.reviewKeywords?.keywords[i],
                              orElse: () => "1") ==
                          "1") {
                        setState(() {
                          selectedKeywords = [
                            ...selectedKeywords,
                            state.reviewKeywords?.keywords[i] ?? "",
                          ];
                        });
                      } else {
                        setState(() {
                          selectedKeywords.removeWhere((element) =>
                              element == state.reviewKeywords?.keywords[i]);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.only(right: 10, bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: AppColors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: selectedKeywords.firstWhere(
                                    (element) =>
                                        element ==
                                        state.reviewKeywords?.keywords[i],
                                    orElse: () => "1") !=
                                "1"
                            ? AppColors.primaryLighter
                            : AppColors.white,
                      ),
                      child: Text(state.reviewKeywords?.keywords[i] ?? ""),
                    ),
                  )
                ]
              ],
            );
          },
        ),
      ],
    );
  }

  TextEditingController shareMoreController = TextEditingController();
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
        TextField(
          controller: shareMoreController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Tiếp tục nào, hãy để lại cảm nhận của bạn...",
            hintStyle: AppTextStyle.greyS14,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.redAccent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}

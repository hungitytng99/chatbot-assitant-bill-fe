import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/models/enums/exercise_review_type.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';

class ExerciseReviewPage extends StatefulWidget {
  ExerciseReviewPage({
    Key? key,
  }) : super(key: key);
  @override
  _ExerciseReviewPageState createState() => _ExerciseReviewPageState();
}

class _ExerciseReviewPageState extends State<ExerciseReviewPage> {
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildStarReview(
                    title: "Đánh giá về cơ thể",
                    description: 'Mô tả gì đó',
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
                    height: 16,
                  ),
                  AppButton(
                    title: "Gửi đánh giá".toUpperCase(),
                    textStyle: AppTextStyle.whiteS14Bold.copyWith(
                      fontSize: 16,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    isLoading: false,
                    onPressed: () {
                      // _appCubit.logout();
                    },
                  ),
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

  Widget _buildStarReview({
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
            print(rating);
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

  Widget _buildPracticeReview({
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
        Wrap(
          children: [
            for (int i = 0; i < 20; i++) ...[
              Container(
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
                  color:
                      i % 2 == 0 ? AppColors.primaryLighter : AppColors.white,
                ),
                child: Text('Tốt quá rồi ${i * 10}'),
              )
            ]
          ],
        ),
      ],
    );
  }

  TextEditingController textarea = TextEditingController();
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
          controller: textarea,
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

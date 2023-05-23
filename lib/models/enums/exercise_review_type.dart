import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';

enum ExerciseReviewEnum {
  bad,
  good,
}

extension ExerciseReviewExtension on ExerciseReviewEnum {
  String get title {
    switch (this) {
      case ExerciseReviewEnum.good:
        return 'Tốt';
      case ExerciseReviewEnum.bad:
        return 'Tệ';
    }
  }

  String get value {
    switch (this) {
      case ExerciseReviewEnum.good:
        return 'good';
      case ExerciseReviewEnum.bad:
        return 'bad';
    }
  }

  Icon get activeIcon {
    switch (this) {
      case ExerciseReviewEnum.good:
        return Icon(
          Icons.thumb_up,
          size: 45,
          color: AppColors.main,
        );
      case ExerciseReviewEnum.bad:
        return Icon(
          Icons.thumb_down,
          size: 45,
          color: AppColors.main,
        );
    }
  }

  Icon get deActiveIcon {
    switch (this) {
      case ExerciseReviewEnum.good:
        return const Icon(
          Icons.thumb_up,
          size: 45,
          color: AppColors.grey,
        );
      case ExerciseReviewEnum.bad:
        return const Icon(
          Icons.thumb_down,
          size: 45,
          color: AppColors.grey,
        );
    }
  }
}

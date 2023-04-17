import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_theme.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  final Color color;

  const AppCircularProgressIndicator({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: color,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
        ),
      ),
    );
  }
}

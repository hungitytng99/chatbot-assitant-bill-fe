import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Color color;
  final double size;

  const LoadingIndicatorWidget({Key? key,  this.color = const Color(0xFFF17B00), this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          backgroundColor: color,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.loadingIndicator),
        ),
      ),
    );
  }
}

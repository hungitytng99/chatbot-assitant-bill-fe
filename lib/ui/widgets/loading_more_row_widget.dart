import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';

class LoadingMoreRowWidget extends StatelessWidget {
  final double height;
  final Color color;

  const LoadingMoreRowWidget(
      {Key? key, this.height = 80, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            backgroundColor: color,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ),
        ),
      ),
    );
  }
}

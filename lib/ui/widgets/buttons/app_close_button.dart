import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';

class AppCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? color;

  const AppCloseButton({
    Key? key,
    this.onPressed,
    this.width = 40,
    this.height = 40,
    this.color = AppColors.textGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Icon(
            Icons.close,
            color: color,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final double width;
  final double height;
  final Color? color;

  const AppBackButton({
    Key? key,
    this.onBackPressed,
    this.width = 40,
    this.height = 40,
    this.color = AppColors.textGrayTitleDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      // color: Colors.red,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onBackPressed,
        icon: Icon(
          Icons.chevron_left_rounded,
          color: color,
          size: 32,
        ),
      ),
    );
  }
}

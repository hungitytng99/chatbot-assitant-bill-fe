import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/ui/components/app_cache_image.dart';

class ButtonTile extends StatelessWidget {
  Widget? title = const Text("");
  Widget? subTitle = const Text("");
  Widget? secondSubTitle = const Text("");
  VoidCallback? onPressed = () => {};
  Widget? iconWidget =
      const AppCacheImage(url: "", fit: BoxFit.cover, width: 41, height: 41);
  Widget? iconExpandMore = const SizedBox.shrink();
  Color? backgroundColor = Colors.white;
  final Color? borderColor;
  double? distanceIconText = 5;
  double? height;
  double? width;
  double? paddingContainer;

  ButtonTile({
    this.title,
    this.height,
    this.width,
    this.subTitle,
    this.secondSubTitle,
    this.onPressed,
    this.iconWidget,
    this.backgroundColor,
    this.distanceIconText,
    this.iconExpandMore,
    this.borderColor,
    this.paddingContainer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor == null
              ? null
              : BorderSide(width: 1, color: borderColor!),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size(0, 32),
          padding: EdgeInsets.symmetric(horizontal: paddingContainer ?? 15),
        ),
        child: Row(
          children: <Widget>[
            iconWidget!,
            SizedBox(width: distanceIconText),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  title!,
                  subTitle == null ? const SizedBox() : const SizedBox(height: 4),
                  subTitle ?? const SizedBox(),
                  secondSubTitle == null ? const SizedBox() : const SizedBox(height: 4),
                  secondSubTitle ?? const SizedBox(),
                ],
              ),
            ),
            iconExpandMore == null
                ? const Text("")
                : Container(
                    padding: const EdgeInsets.only(left: AppDimens.paddingS8, right: AppDimens.paddingSmall, top: AppDimens.paddingSmall),
                    child: iconExpandMore,
                  ),
          ],
        ),
      ),
    );
  }
}

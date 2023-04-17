import 'package:flutter/cupertino.dart';
import 'package:ihz_bql/common/app_images.dart';

class SplashFooterHeaderWidget extends StatelessWidget {
  final isShow = /*AppConfig.themeConfig.showFooterHeaderImage*/ true;

  const SplashFooterHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: isShow
          ? const SizedBox()
          : null,
    );
  }
}

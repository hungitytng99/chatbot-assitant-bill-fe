import 'package:flutter/material.dart';

class ScreenSize {
  late double width;
  late double height;
  late double topPadding;
  late double bottomPadding;

  ScreenSize.of(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    topPadding = _mediaQueryData.padding.top;
    bottomPadding = _mediaQueryData.padding.bottom;
  }
}

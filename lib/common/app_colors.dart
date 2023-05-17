import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static void configFromRemote({
    Color? primaryColor,
    Color? primaryLighterColor,
    Color? secondaryColor,
    Color? secondaryLighterColor,
    Color? gradientStartColor,
    Color? gradientEndColor,
  }) {
    primary = primaryColor ?? _defaultPrimary;
    primaryLighter = primaryLighterColor ?? _defaultPrimaryLighter;
    secondary = secondaryColor ?? _defaultSecondary;
    secondaryLighter = secondaryLighterColor ?? _defaultSecondaryLighter;
    appBarGradientTop = gradientStartColor ?? _defaultGradientStart;
    appBarGradientBottom = gradientEndColor ?? _defaultGradientEnd;
  }

  static const Color _defaultPrimary = Color(0xFFf17b00);
  static const Color _defaultPrimaryLighter = Color(0xFFFFE4CE);
  static const Color _defaultSecondary = Color(0xFFD20043);
  static const Color _defaultSecondaryLighter = Color(0xFFFFDEE9);
  static const Color _defaultGradientStart = Color(0xFFf17b00);
  static const Color _defaultGradientEnd = Color(0xFFD20043);

  ///Dynamic color
  static Color primary = _defaultPrimary;
  static Color primaryLighter = _defaultPrimaryLighter;
  static Color secondary = _defaultSecondary;
  static Color secondaryLighter = _defaultSecondaryLighter;

  static const Color signInPrimary = Color(0xFFF17B00);

  static Color action = secondary;
  static Color actionLighter = action.withOpacity(0.2);

  ///Common
  static Color get main => primary;

  static Color mainLighter = primaryLighter;
  static const Color white = Color(0xFFFFFFFF);
  static const Color backgroundGray = Color(0xFFF8F8F8);
  static const Color loadingIndicator = Color(0xFF00AFA5);
  static const Color shadowColor = Color(0x29000000);
  static const Color borderColor = Color(0xFF606060);
  static const Color borderColorD6 = Color(0xFFD6D6D6);
  static const Color borderColor70 = Color(0xFF707070);
  static const Color borderGrayColor = Color(0xFFE0E0E0);

  ///Text
  static Color textTint = main;
  static const Color textBlack = Color(0xFF333333);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFF58595B);
  static const Color textGrayDarker = Color(0xFF333333);
  static const Color textRed = Color(0xFFFF0000);
  static const Color textGrayTitleDocument = Color(0xFF707070);
  static const Color textOrange = Color(0xFFF17B00);

  ///TextField
  static const Color textFieldBorder = Color(0xFF919191);

  ///Button
  static const Color buttonGreen = Color(0xFF00a21f);
  static const Color buttonRed = Color(0xFFFF0000);

  static Color get buttonTint => primary;
  static const Color buttonGrey = Color(0xFF919191);

  ///Line or separator or divider
  static const Color lineGray = Color(0xFF919191);
  static const Color separator = lineGray;
  static const Color divider = lineGray;

  ///Appbar
  static Color appBarGradientTop = _defaultGradientStart;
  static Color appBarGradientBottom = _defaultGradientEnd;

  ///Other
  static const Color gray = Color(0xFF606060);
  static const Color grayF4 = Color(0xFFF4F4F4);
  static const Color grayLighter = Color(0xFFEBEBEB);
  static const Color gray000000B3 = Color(0xFF4C4C4C);
  static const Color bgErrorSnackBar = Color(0xFFEBEBEB);
  static const Color bgWarningSnackBar = Color(0xFFFFE9BE);

  // bottom barr
  static const Color activeColorItem = Color(0xFFFFE4CE);
  static const Color activeColorText = Color(0xFFF17B00);

  ///Request management
  static const Color bgNotificationRequestManage = Color(0xFFD20043);

  // top content

  static const Color topContent = Color(0xFFF7bd94);

  ///AppContent
  static const Color appPopulationGradientTop = Color(0xFFEF7305);

  static Color get appContentGradientTop => topContent;
  static Color get appContentGradientBody => activeColorText;

  static Color get appContentGradientBottom => bgNotificationRequestManage;
  static const Color greyDBDBDB = Color(0xFFDBDBDB);
  static const Color orange = Color(0xFFFFA700);

  static const Color orangeFFD584 = Color(0xFFFFD584);
  static const Color orangeFFE4CE = Color(0xFFFFE4CE);
  static const Color greenC5EBB8 = Color(0xFFC5EBB8);
  static const Color greenRequest = Color(0xFF00860A);
  static const Color textFieldEnabledBorder = Color(0xFF919191);
  static const Color textFieldDisabledBorder = Color(0xFF919191);

  static const Color lightRed = Color(0xFFFF4E4E);
  static const Color lightGrey = Color(0xFFA0A0A0);
  static const Color lightYellow = Color(0xFFF6BD43);
  static const Color matterOrange = Color(0xFFF17B00);
  static const Color lightBlue = Color(0xFF0065FF);
  static const Color grey = Color(0xFFE6E6E4);
  static const Color greyE9 = Color(0xFFE9E9E9);
}

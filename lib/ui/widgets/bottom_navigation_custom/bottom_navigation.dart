import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class BottomNavyBar extends StatelessWidget {
  const BottomNavyBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.backgroundColor,
    this.itemCornerRadius = 18,
    this.containerHeight = 55,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);
  final int selectedIndex;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: containerHeight,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return InkWell(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  borderRadius: index == 0
                      ? BorderRadius.only(
                          topRight: Radius.circular(itemCornerRadius),
                        )
                      : index == 3
                          ? BorderRadius.only(
                              topLeft: Radius.circular(itemCornerRadius),
                            )
                          : BorderRadius.only(
                              topRight: Radius.circular(itemCornerRadius),
                              topLeft: Radius.circular(itemCornerRadius),
                            ),
                  item: item,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final BorderRadiusGeometry borderRadius;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.backgroundColor,
      required this.animationDuration,
      required this.itemCornerRadius,
      this.curve = Curves.linear,
      required this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 70,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLighter : backgroundColor,
          // ignore: unrelated_type_equality_checks
          borderRadius: borderRadius,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 140 : 70,
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingS12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(item.icon,
                    color: isSelected ? AppColors.primary : null),
                isSelected
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DefaultTextStyle.merge(
                            style: AppTextStyle.primaryS14Bold,
                            maxLines: 1,
                            textAlign: item.textAlign,
                            child: item.title,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.textAlign,
  });

  final String icon;
  final Widget title;
  final TextAlign? textAlign;
}

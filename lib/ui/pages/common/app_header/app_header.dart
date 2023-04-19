import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_shadow.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';

class AppHeader extends StatefulWidget {
  String title;
  AppHeader({
    required this.title,
    Key? key,
  }) : super(key: key);
  @override
  _AppHeaderState createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> with TickerProviderStateMixin {
  late TabController _tabMenuController;
  final Duration duration = const Duration(milliseconds: 300);
  Animation<double>? _scaleAnimation;
  double? screenWidth, screenHeight;
  bool isCollapsed = true;
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _menuScaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return _buildBody();
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          menu(context),
          mainPage(context),
        ],
      ),
    );
  }

  Stack _buildAppBar(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: AppTextStyle.blackS18Bold,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const AppCacheImage(
              width: 40,
              height: 40,
              borderRadius: 20,
              url:
                  "https://assets1.cbsnewsstatic.com/hub/i/2018/11/06/0c1af1b8-155a-458e-b105-78f1e7344bf4/2018-11-06t054310z-1334124005-rc1be15a8050-rtrmadp-3-people-sexiest-man.jpg",
            ),
          ),
        )
      ],
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation ??
          Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
              .animate(_controller!),
      child: ScaleTransition(
        scale: _menuScaleAnimation ??
            Tween<double>(begin: 0.5, end: 1).animate(_controller!),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20,
              bottom: 20,
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[Text('Menu here')],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mainPage(context) {
    DateTime currentDateTime = DateTime.now();
    int currentWeekDay = currentDateTime.weekday;

    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.6 * screenWidth!,
        right: isCollapsed ? 0 : -0.2 * screenWidth!,
        child: ScaleTransition(
          scale: _scaleAnimation ??
              Tween<double>(begin: 1, end: 0.8).animate(_controller!),
          child: SafeArea(
            top: isCollapsed ? false : true,
            bottom: false,
            right: false,
            left: false,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: AppShadow.boxShadowLarge,
                color: AppColors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(isCollapsed ? 0 : 25)),
              ),
              child: RefreshIndicator(
                color: AppColors.main,
                onRefresh: () async {},
                child: Stack(
                  children: [
                    Visibility(
                      visible: isCollapsed == true ? false : true,
                      child: GestureDetector(
                        onTap: () {
                          if (isCollapsed == false) {
                            setState(() {
                              _controller?.reverse();
                              isCollapsed = !isCollapsed;
                            });
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: const Text('123'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_shadow.dart';
import 'package:ihz_bql/configs/app_configs.dart';

import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/ui/components/app_cache_image.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_page.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:ihz_bql/ui/pages/homepage/home_cubit.dart';
import 'package:ihz_bql/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<NavigatorState> chatNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> contactNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> courseNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double? screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _menuScaleAnimation;
  Animation<Offset>? _slideAnimation;
  AppCubit? _appCubit;
  late HomeCubit _homeCubit;
  final PageController pageController = PageController();
  late bool? inPageOrderType;
  late final pages;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_animationController!);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_animationController!);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_animationController!);
    _appCubit = BlocProvider.of<AppCubit>(context);
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    pages = [
      Navigator(
        key: widget.chatNavigatorKey,
        onGenerateRoute: (routeSettings) {
          late Widget page;
          switch (routeSettings.name) {
            case "/":
              page = MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: _homeCubit,
                  ),
                ],
                child: ChatListPage(),
              );
              break;
          }
          return MaterialPageRoute<dynamic>(
            builder: (context) {
              return page;
            },
            settings: routeSettings,
          );
        },
      ),
      Navigator(
        key: widget.contactNavigatorKey,
        onGenerateRoute: (routeSettings) {
          late Widget page;
          switch (routeSettings.name) {
            case "/":
              page = const Text("Contact page");
              page = MultiBlocProvider(
                providers: [BlocProvider.value(value: _homeCubit)],
                child: ContactListPage(),
              );

              break;
          }
          return MaterialPageRoute<dynamic>(
            builder: (context) {
              return page;
            },
            settings: routeSettings,
          );
        },
      ),
      Navigator(
        key: widget.courseNavigatorKey,
        onGenerateRoute: (routeSettings) {
          late Widget page;
          switch (routeSettings.name) {
            case "/":
              page = MultiBlocProvider(
                providers: [BlocProvider.value(value: _homeCubit)],
                child: CourseListPage(),
              );
              break;
          }
          return MaterialPageRoute<dynamic>(
            builder: (context) {
              return page;
            },
            settings: routeSettings,
          );
        },
      ),
    ];
  }

  @override
  void dispose() {
    _animationController?.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Menu(context),
          MainPage(context),
        ],
      ),
    );
  }

  Widget Menu(context) {
    return SlideTransition(
      position: _slideAnimation ??
          Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
              .animate(_animationController!),
      child: ScaleTransition(
        scale: _menuScaleAnimation ??
            Tween<double>(begin: 0.5, end: 1).animate(_animationController!),
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
                children: <Widget>[
                  _buildUserInfoWidget(),
                  _buildListPolicies(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MainPage(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth!,
      right: isCollapsed ? 0 : -0.2 * screenWidth!,
      child: ScaleTransition(
        scale: _scaleAnimation ??
            Tween<double>(begin: 1, end: 0.8).animate(_animationController!),
        child: Container(
            decoration: BoxDecoration(
              boxShadow: AppShadow.boxShadowLarge,
              color: AppColors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(isCollapsed ? 0 : 25)),
            ),
            child: SafeArea(
                child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.currentPage != current.currentPage,
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          child: const Icon(
                            Icons.menu,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                _animationController?.forward();
                              } else {
                                _animationController?.reverse();
                              }

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Expanded(
                      child: PageView(
                        children: pages,
                        controller: pageController,
                        onPageChanged: (value) {
                          _homeCubit.changePage(value);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ],
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildNavButton(
                                AppImages.icChatBubble,
                                "Đoạn chat",
                                onPressed: () {
                                  _homeCubit.changePage(0);
                                  pageController.jumpToPage(0);
                                },
                                isSelected:
                                    state.currentPage == 0 ? true : false,
                              ),
                            ),
                            Expanded(
                              child: _buildNavButton(
                                AppImages.icContactBook,
                                "Danh bạ",
                                onPressed: () async {
                                  _homeCubit.changePage(1);
                                  pageController.jumpToPage(1);
                                },
                                isSelected:
                                    state.currentPage == 1 ? true : false,
                              ),
                            ),
                            Expanded(
                              child: _buildNavButton(
                                AppImages.icLearning,
                                "Khóa học",
                                onPressed: () async {
                                  _homeCubit.changePage(2);
                                  pageController.jumpToPage(2);
                                },
                                isSelected:
                                    state.currentPage == 2 ? true : false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ))),
      ),
    );
  }

  Widget _buildUserInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(
          "Mạnh Hùng",
          style: AppTextStyle.blackS18Bold.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          "mhungict99@gmail.com",
          style: AppTextStyle.greyS14
              .copyWith(color: AppColors.textBlack, fontSize: 14),
        ),
        const SizedBox(
          height: 30,
        ),
        _buildItemCategory(
          title: '123',
          iconUrl: AppImages.icUser,
          onPressed: () {
            logger.d("Go to my profile page");
          },
        ),
      ],
    );
  }

  Widget _buildListPolicies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConfigs.appName,
          style: AppTextStyle.blackS18Bold.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 25,
        ),
        _buildItemCategory(
          title: '123',
          iconUrl: AppImages.icUserGrey,
          onPressed: () {
            logger.d("Go to my profile page");
          },
        ),
      ],
    );
  }

  _buildNavButton(String iconUrl, String title,
      {required VoidCallback onPressed, required bool isSelected}) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(
              iconUrl,
              color: isSelected ? AppColors.main : AppColors.shadowColor,
            ),
          ),
          const SizedBox(height: 7.5),
          Text(
            title,
            style: AppTextStyle.blackS12.copyWith(
              color: isSelected ? AppColors.primary : AppColors.textBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCategory({
    required String iconUrl,
    required String title,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            iconUrl,
            width: 18,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: AppTextStyle.blackS16.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/bottom_navigation_shape.dart';
import 'package:ihz_bql/common/screen_size.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:ihz_bql/ui/pages/homepage/home_cubit.dart';

enum RestaurantOrderTypeEnum { onlyTakeaway, onlyDineIn, both, none }

class HomePage extends StatefulWidget {
  final GlobalKey<NavigatorState> chatNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> contactNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> courseNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>();
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppCubit _appCubit;
  late HomeCubit _cubit;
  final PageController pageController = PageController();
  late bool? inPageOrderType;
  late final pages;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context);
    _cubit = HomeCubit();
    pages = [
      Navigator(
        key: widget.chatNavigatorKey,
        onGenerateRoute: (routeSettings) {
          late Widget page;
          switch (routeSettings.name) {
            case "/":
              page = Container(
                child: Text("Chat page"),
              );
              // page = MultiBlocProvider(
              //   providers: [
              //     BlocProvider.value(
              //       value: _homeCubit,
              //     ),
              //     BlocProvider.value(value: _cubit)
              //   ],
              //   child: RestaurantHomePage(
              //     restaurantId: widget.param.restaurantId,
              //     orderType: widget.param.checkDineInOrTake,
              //     orderTypeSetting: widget.param.restaurantOrderType,
              //     controller: _homeScrollController,
              //   ),
              // );
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
              page = Container(
                child: Text("Contact page"),
              );
              // page = MultiBlocProvider(
              //   providers: [
              //     BlocProvider(
              //       create: (context) {
              //         RestaurantRepository restaurantRepository =
              //         RepositoryProvider.of<RestaurantRepository>(context);
              //         return RestaurantFavoriteCubit(restaurantRepository);
              //       },
              //     ),
              //     BlocProvider.value(value: _cubit)
              //   ],
              //   child: RestaurantFavoritePage(
              //     restaurantId: widget.param.restaurantId,
              //     restaurantName: widget.param.restaurantName,
              //     orderType: widget.param.checkDineInOrTake,
              //     pageController: pageController,
              //   ),
              // );

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
              page = Container(
                child: Text("Course page"),
              );
              // page = MultiBlocProvider(
              //   providers: [
              //     BlocProvider(
              //       create: (context) {
              //         RestaurantRepository restaurantRepository =
              //         RepositoryProvider.of<RestaurantRepository>(context);
              //         return RestaurantOrderCubit(restaurantRepository);
              //       },
              //     ),
              //     BlocProvider.value(value: _cubit)
              //   ],
              //   child: RestaurantOrderPage(
              //     restaurantId: widget.param.restaurantId,
              //     restaurantName: widget.param.restaurantName,
              //     pageController: pageController,
              //   ),
              // );
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
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).viewPadding.bottom);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            switch (state.currentPage) {
              case 0:
                if (widget.chatNavigatorKey.currentState != null) {
                  final bool result =
                      await widget.chatNavigatorKey.currentState!.maybePop();
                  if (result)
                    return false;
                  else
                    return true;
                }
                break;
            }
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                PageView(
                  children: pages,
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipShadowPath(
                    clipper: BottomNavBarClippath(),
                    shadow: Shadow(color: Colors.grey, blurRadius: 20),
                    child: Container(
                      height: Platform.isIOS
                          ? MediaQuery.of(context).viewPadding.bottom + 60
                          : 60,
                      padding: EdgeInsets.only(
                          bottom: Platform.isIOS
                              ? (MediaQuery.of(context).viewPadding.bottom == 0
                                  ? 0
                                  : 10)
                              : 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildNavButton(
                              AppImages.icWarning,
                              "Đoạn chat",
                              onPressed: () {
                                _cubit.changePage(0);
                                pageController.jumpToPage(0);
                              },
                              isSelected: state.currentPage == 0 ? true : false,
                            ),
                          ),
                          Expanded(
                            child: _buildNavButton(
                              AppImages.icSearch,
                              "Danh bạ",
                              onPressed: () async {
                                bool? result = true;
                                // if (GlobalData.instance.isGuest) {
                                //   result =
                                //   await DialogUtils.showAuthDialog(context);
                                //   if (result == true)
                                //     _homeCubit.getRestaurantDetail(
                                //         widget.param.restaurantId);
                                //   return;
                                // }

                                _cubit.changePage(1);
                                pageController.jumpToPage(1);
                              },
                              isSelected: state.currentPage == 1 ? true : false,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            child: _buildNavButton(
                              AppImages.icClose,
                              "Khóa học",
                              onPressed: () async {
                                _cubit.changePage(2);
                                pageController.jumpToPage(2);
                              },
                              isSelected: state.currentPage == 2 ? true : false,
                            ),
                          ),
                          Expanded(
                            child: _buildNavButton(
                              AppImages.icUser,
                              "Tôi",
                              onPressed: () async {
                                _cubit.changePage(3);
                                pageController.jumpToPage(3);
                              },
                              isSelected: state.currentPage == 3 ? true : false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: ScreenSize.of(context).width / 2 - 30,
                  bottom: Platform.isIOS
                      ? ((MediaQuery.of(context).viewPadding.bottom == 0)
                          ? 30
                          : MediaQuery.of(context).viewPadding.bottom + 15)
                      : 30,
                  child: InkWell(
                    onTap: () async {},
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.main,
                          radius: 30,
                          child: Image.asset(AppImages.icUser),
                        ),
                        Positioned(
                          top: -4,
                          right: -6,
                          child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  color: AppColors.main,
                                  border: Border.all(
                                    color: AppColors.primaryLighter,
                                    width: 2,
                                  )),
                              child: BlocConsumer<AppCubit, AppState>(
                                bloc: _appCubit,
                                buildWhen: (prev, curr) => true,
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return Center(
                                      child: Text(
                                    "123",
                                    style: AppTextStyle.whiteS16Bold,
                                  ));
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
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
              color: isSelected ? AppColors.main : null,
            ),
          ),
          SizedBox(height: 7.5),
          Text(
            title,
            style: AppTextStyle.blackS12.copyWith(
                color: isSelected ? AppColors.main : AppColors.textBlack),
          ),
        ],
      ),
    );
  }
}

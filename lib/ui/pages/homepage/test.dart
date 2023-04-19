import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_page.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:ihz_bql/ui/pages/homepage/home_cubit.dart';
import 'package:ihz_bql/ui/pages/profile/my_profile/my_profile_cubit.dart';

import '../profile/my_profile/my_profile_page.dart';

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
  late HomeCubit _homeCubit;

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
  Widget build(BuildContext context) {
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
                  if (result) {
                    return false;
                  } else {
                    return true;
                  }
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
                  physics: const NeverScrollableScrollPhysics(),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
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
                            // Expanded(
                            //   child: _buildNavButton(
                            //     AppImages.icSettings,
                            //     "Cá nhân",
                            //     onPressed: () async {
                            //       Navigator.of(context).push(
                            //         MaterialPageRoute(
                            //           builder: (context) => MultiBlocProvider(
                            //             providers: [
                            //               BlocProvider.value(value: _homeCubit),
                            //               BlocProvider(
                            //                 create: (context) {
                            //                   return MyProfileCubit();
                            //                 },
                            //               ),
                            //             ],
                            //             child: const MyProfilePage(),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //     isSelected:
                            //         state.currentPage == 3 ? true : false,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ))
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
}

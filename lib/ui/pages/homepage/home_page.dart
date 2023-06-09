import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_shadow.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:ihz_bql/database/share_preferences_helper.dart';
import 'package:ihz_bql/globals/global_data.dart';
import 'package:ihz_bql/models/entities/expert_entity.dart';
import 'package:ihz_bql/repositories/conversation_repository.dart';
import 'package:ihz_bql/repositories/diary_repository.dart';
import 'package:ihz_bql/repositories/diary_repository.dart';
import 'package:ihz_bql/repositories/exercise_repository.dart';
import 'package:ihz_bql/repositories/expert_repository.dart';
import 'package:ihz_bql/repositories/hashtag_repository.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/components/app_cache_image.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_cubit.dart';
import 'package:ihz_bql/ui/pages/chat/chat_list/chat_list_page.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_cubit.dart';
import 'package:ihz_bql/ui/pages/contact/contact_list/contact_list_page.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_cubit.dart';
import 'package:ihz_bql/ui/pages/course/course_list/course_list_page.dart';
import 'package:ihz_bql/ui/pages/diary/diary/diary_cubit.dart';
import 'package:ihz_bql/ui/pages/diary/diary/diary_page.dart';
import 'package:ihz_bql/ui/pages/homepage/home_cubit.dart';
import 'package:ihz_bql/ui/pages/profile/my_profile/my_profile_cubit.dart';
import 'package:ihz_bql/ui/pages/profile/my_profile/my_profile_page.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Tabs {
  String title;
  String iconUrl;
  int index;

  Tabs({
    required this.index,
    required this.title,
    required this.iconUrl,
  });
}

class HomePage extends StatefulWidget {
  final GlobalKey<NavigatorState> chatNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> contactNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> courseNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> diaryNavigatorKey =
      GlobalKey<NavigatorState>();

  int pageIndex;
  ExpertEntity? expertEntity;

  HomePage({
    Key? key,
    this.pageIndex = 2,
    this.expertEntity,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double? screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 200);
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _menuScaleAnimation;
  Animation<Offset>? _slideAnimation;
  AppCubit? _appCubit;
  late ContactListCubit _contactListCubit;
  late CourseListCubit _courseListCubit;
  late ChatListCubit _chatListCubit;
  late DiaryCubit _diaryCubit;
  late HomeCubit _homeCubit;
  late PageController pageController;
  late bool? inPageOrderType;
  late final pages;

  List<Tabs> listTabs = [
    Tabs(index: 0, title: 'Khám phá', iconUrl: AppImages.icMeditation),
    Tabs(index: 1, title: 'Chuyên gia', iconUrl: AppImages.icContactBook),
    Tabs(index: 2, title: 'Đoạn chat', iconUrl: AppImages.icChatBubble),
    Tabs(index: 3, title: 'Nhật ký', iconUrl: AppImages.icDiary),
  ];

  @override
  void initState() {
    super.initState();
    ExpertRepository expertRepository =
        RepositoryProvider.of<ExpertRepository>(context);
    ConversationsRepository conversationsRepository =
        RepositoryProvider.of<ConversationsRepository>(context);
    _contactListCubit = ContactListCubit(expertRepository: expertRepository);
    _chatListCubit = ChatListCubit(
        expertRepository: expertRepository,
        conversationsRepository: conversationsRepository);

    ExerciseRepository exerciseRepository =
        RepositoryProvider.of<ExerciseRepository>(context);
    HashTagsRepository hashTagsRepository =
        RepositoryProvider.of<HashTagsRepository>(context);
    _courseListCubit = CourseListCubit(
      exerciseRepository: exerciseRepository,
      hashTagsRepository: hashTagsRepository,
    );

    DiaryRepository diaryRepository =
        RepositoryProvider.of<DiaryRepository>(context);
    _diaryCubit = DiaryCubit(diaryRepository: diaryRepository);

    pages = [
      Navigator(
        key: widget.courseNavigatorKey,
        onGenerateRoute: (routeSettings) {
          late Widget page;
          switch (routeSettings.name) {
            case "/":
              page = MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: _homeCubit),
                  BlocProvider.value(value: _courseListCubit),
                ],
                child: CourseListPage(
                    expertEntity: widget.expertEntity,
                    resetExpertEntity: () {
                      widget.expertEntity = null;
                    }),
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
                providers: [
                  BlocProvider.value(value: _homeCubit),
                  BlocProvider.value(value: _contactListCubit),
                ],
                child: const ContactListPage(),
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
                  BlocProvider.value(
                    value: _chatListCubit,
                  ),
                ],
                child: const ChatListPage(),
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
        key: widget.diaryNavigatorKey,
        onGenerateRoute: (routeSettings) {
          late Widget page;
          switch (routeSettings.name) {
            case "/":
              page = MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: _diaryCubit,
                  ),
                ],
                child: DiaryPage(),
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

    pageController = PageController(initialPage: widget.pageIndex);
    _homeCubit.changePage(widget.pageIndex);
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
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: <Widget>[
            Menu(context),
            MainPage(context),
          ],
        ),
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
                top: isCollapsed,
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.currentPage != current.currentPage,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                          height: 55,
                          padding: const EdgeInsets.only(left: 14),
                          child: _buildAppBar(context),
                        ),
                        const SizedBox(height: 2),
                        Expanded(
                          child: PageView(
                            children: pages,
                            controller: pageController,
                            onPageChanged: (pageIndex) {
                              _homeCubit.changePage(pageIndex);
                            },
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            border: const Border(
                              top: BorderSide(
                                  width: 1.0, color: AppColors.borderColorD6),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(children: [
                              ...listTabs.map(
                                (tab) => Expanded(
                                  child: _buildNavButton(
                                    tab.iconUrl,
                                    tab.title,
                                    onPressed: () async {
                                      pageController.jumpToPage(
                                        tab.index,
                                      );
                                    },
                                    isSelected: state.currentPage == tab.index
                                        ? true
                                        : false,
                                  ),
                                ),
                              )
                            ]),
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
          _appCubit?.state.userEntity?.fullName ?? "",
          style: AppTextStyle.blackS18Bold.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          _appCubit?.state.userEntity?.username ?? "",
          style: AppTextStyle.greyS14
              .copyWith(color: AppColors.textBlack, fontSize: 14),
        ),
        const SizedBox(
          height: 30,
        ),
        _buildItemCategory(
          title: 'Hồ sơ cá nhân',
          iconUrl: AppImages.icUserGrey,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _homeCubit),
                    BlocProvider(
                      create: (context) {
                        return MyProfileCubit();
                      },
                    ),
                  ],
                  child: const MyProfilePage(),
                ),
              ),
            );
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
          style: AppTextStyle.primaryS18Bold.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          "Thư thái - Sáng suốt - Năng động",
          style: AppTextStyle.primaryS14.copyWith(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        AppButton(
          leadingIcon: Container(
              margin: const EdgeInsets.only(right: 6),
              child: Image.asset(AppImages.icLogout)),
          title: 'Đăng xuất',
          height: 45,
          width: 150,
          textStyle: AppTextStyle.whiteS14Bold.copyWith(
            fontSize: 16,
          ),
          cornerRadius: 25,
          backgroundColor: AppColors.signInPrimary,
          disableBackgroundColor: Colors.black,
          onPressed: () {
            SharedPreferencesHelper.setApiTokenKey("");
            GlobalData.instance.token = null;
            Application.router.navigateTo(
              context,
              Routes.signIn,
            );
          },
          isLoading: false,
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
            width: 24,
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

  Stack _buildAppBar(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              previous.currentPage != current.currentPage,
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              height: 55,
              margin: EdgeInsets.only(left: isCollapsed ? 0 : 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    listTabs[state.currentPage].title,
                    style: AppTextStyle.blackS18Bold,
                  ),
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
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
              child: const AppCacheImage(
                width: 40,
                height: 40,
                borderRadius: 45,
                url:
                    "https://res.cloudinary.com/dzhowprbg/image/upload/v1687864178/186510188_1680599485483470_1822133296017458249_n_ax9t52.jpg",
              )),
        )
      ],
    );
  }
}

class HomePageArgument {
  int pageIndex;
  ExpertEntity? expertEntity;
  HomePageArgument({
    required this.pageIndex,
    this.expertEntity,
  });
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/otp_layout.dart';
import 'package:ihz_bql/database/share_preferences_helper.dart';
import 'package:ihz_bql/globals/global_data.dart';
import 'package:ihz_bql/models/enums/file_source_type.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/components/app_cache_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/ui/pages/profile/my_profile/my_profile_cubit.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';
import 'package:ihz_bql/utils/dialog_utils.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage();

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with WidgetsBindingObserver {
  late AppCubit _appCubit;
  late MyProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context);
    _profileCubit = BlocProvider.of<MyProfileCubit>(context);
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: BlocConsumer<MyProfileCubit, MyProfileState>(
          bloc: _profileCubit,
          listenWhen: (prev, curr) => true,
          listener: (context, state) {
          },
          builder: (context, state) {
            return _buildBody();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return OTPLayout(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<AppCubit, AppState>(
                bloc: _appCubit,
                buildWhen: (prev, curr) => true,
                builder: (context, state) {
                  return _buildUserCardInfo();
                },
              ),
              const SizedBox(
                height: 35,
              ),
              _buildSettingItem(
                title: "Cập nhật thông tin cá nhân",
                iconUrl: AppImages.icUserGrey,
                onPressed: () async {
                  Application.router.navigateTo(context, Routes.updateProfile);
                },
                rightSettingWidget: Image.asset(
                  AppImages.icArrowRight,
                ),
              ),
              const Expanded(child: SizedBox()),
              BlocConsumer<AppCubit, AppState>(
                buildWhen: (previous, current) => true,
                listener: (context, state) {
                  // if (state.logoutState == LoadStatus.SUCCESS) {
                  //   Application.router!.navigateTo(
                  //     context,
                  //     Routes.login,
                  //     transition: TransitionType.fadeIn,
                  //     clearStack: true,
                  //   );
                  //   FlushBarUtils.showSuccessDialog(
                  //       context: context,
                  //       message: S.current.homepage_logoutSuccessfully);
                  //   _appCubit.resetState();
                  //   BlocProvider.of<HomeCubit>(context).resetState();
                  // }
                },
                builder: (context, state) {
                  return AppButton(
                    title: "Đăng xuất".toUpperCase(),
                    textStyle: AppTextStyle.whiteS14Bold.copyWith(
                      fontSize: 16,
                    ),
                    width: MediaQuery.of(context).size.width - 90,
                    height: 45,
                    isLoading: false,
                    onPressed: () {
                      SharedPreferencesHelper.setApiTokenKey("");
                      GlobalData.instance.token = null;
                      Application.router.navigateTo(
                        context,
                        Routes.signIn,
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: Platform.isIOS ? 40 : 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCardInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUserAvatar(),
          const SizedBox(
            height: 12,
          ),
          Text(
            _appCubit.state.userEntity?.fullName ?? "",
            style: AppTextStyle.blackS16Bold.copyWith(fontSize: 20),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            _appCubit.state.userEntity?.username ?? "",
            style: AppTextStyle.greyS14.copyWith(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Stack(
      children: [
        false
            ? ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Image.asset(
                  AppImages.icImagePlaceHolder,
                  height: 90,
                  width: 90,
                ),
              )
            : const AppCacheImage(
                width: 90,
                height: 90,
                borderRadius: 45,
                url:
                    "https://res.cloudinary.com/dzhowprbg/image/upload/v1687864178/186510188_1680599485483470_1822133296017458249_n_ax9t52.jpg",
              ),
        Positioned(
          bottom: -8,
          right: -8,
          child: GestureDetector(
            child: Image.asset(AppImages.icEditRed),
            onTap: () async {
              final file = await DialogUtils.pickFile(
                context,
                sourceTypes: [
                  FileSourceType.camera,
                  FileSourceType.library,
                ],
                title: "Sửa ảnh đại diện",
              );
              if (file != null) {
                /// TODO: Tải ảnh lên
                // _profileCubit.updateAvatar(avatar: file.file);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildSettingItem({
    required String iconUrl,
    required String title,
    required VoidCallback onPressed,
    Widget? rightSettingWidget,
  }) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          padding:
              const EdgeInsets.only(top: 15, bottom: 20, right: 25, left: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconUrl,
                width: 18,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.black.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Visibility(
                visible: rightSettingWidget != null,
                child: rightSettingWidget ?? Container(),
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/models/enums/file_source_type.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/ui/pages/profile/update_profile/update_profile_cubit.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_back_button.dart';
import 'package:ihz_bql/ui/widgets/images/app_cache_image.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_email_input.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_label_text_field.dart';
import 'package:ihz_bql/utils/dialog_utils.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UpdateProfilePageState();
  }
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  late UpdateProfileCubit _cubit;
  late AppCubit _appCubit;
  @override
  void initState() {
    _cubit = UpdateProfileCubit();
    _appCubit = BlocProvider.of<AppCubit>(context);
    _fullNameController.text = _appCubit.state.userEntity?.fullName ?? "";
    _emailController.text = _appCubit.state.userEntity?.username ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                bloc: _cubit,
                // listenWhen: (previous, current) =>
                //     previous.signUpStatus != current.signUpStatus,
                // listener: (context, state) {
                //   if (state.signUpStatus == LoadStatus.success) {
                //     AppDialog.showSuccessDialog(
                //       context,
                //       title: 'Đăng ký tài khoản thành công',
                //       icon: SvgPicture.asset(AppVectors.icSignUpSuccessAlert),
                //       okText: "Đăng nhập ngay!",
                //
                //       onOkPressed: () => Get.offAndToNamed(RouteConfig.signIn),
                //     );
                //   }
                // },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 15),
                        child: AppBackButton(
                          onBackPressed: Get.back,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.paddingNormal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: _buildUserAvatar(),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                'Cập nhật thông tin'.toUpperCase(),
                                style: AppTextStyle.tintS16Bold
                                    .copyWith(color: AppColors.signInPrimary),
                              ),
                            ),
                            const SizedBox(height: 16),
                            AppLabelTextField(
                              labelText: 'Họ và tên',
                              controller: _fullNameController,
                              isRequire: true,
                              onChanged: (value) {
                                _cubit.changeName(value);
                              },
                            ),
                            const SizedBox(height: 16),
                            AppEmailInput(
                              textEditingController: _emailController,
                              isRequire: true,
                              onChanged: (value) {
                                _cubit.changeEmail(value);
                              },
                            ),
                            const SizedBox(height: 35),
                            _buildUpdateButton(),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ));
  }

  Widget _buildUserAvatar() {
    return Stack(
      children: [
        const AppCacheImage(
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

  Widget _buildUpdateButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          bloc: _cubit,
          listenWhen: (previous, current) {
            return previous.checkUserStatus != current.checkUserStatus;
          },
          listener: (context, state) {
            if (state.checkUserStatus == LoadStatus.success) {}
          },
          buildWhen: (previous, current) => true,
          builder: (context, state) {
            return AppButton(
              title: 'Cập nhật'.toUpperCase(),
              isEnable: state.isValidData,
              height: 45,
              textStyle: AppTextStyle.whiteS14Bold.copyWith(
                fontSize: 16,
              ),
              cornerRadius: 25,
              backgroundColor: AppColors.signInPrimary,
              disableBackgroundColor: Colors.black,
              onPressed: () {
                _cubit.checkDuplicateUser();
              },
              isLoading: false,
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

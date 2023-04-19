import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
import 'package:ihz_bql/ui/widgets/pickers/app_date_picker.dart';
import 'package:ihz_bql/ui/widgets/pickers/app_identity_date_picker.dart';
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
  final _fullNameController = TextEditingController(text: 'Trần Mạnh Hùng');
  final _emailController = TextEditingController(text: 'mhungict99@gmail.com');
  final _identityDateController = DatePickerController(dateTime: DateTime.now());

  late UpdateProfileCubit _cubit;
  @override
  void initState() {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    _cubit = UpdateProfileCubit();
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
                    children: [
                      Row(
                        children: [
                          AppBackButton(
                            onBackPressed: Get.back,
                          ),
                        ],
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
                            AppIdentifyDatePicker(
                              controller: _identityDateController,
                              label: "Ngày/tháng/năm sinh",
                              onChanged: (date) => _cubit.changeBornDate(date),
                            ),
                            const SizedBox(height: 35),
                            _buildSignupButton(),
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
                    "https://assets1.cbsnewsstatic.com/hub/i/2018/11/06/0c1af1b8-155a-458e-b105-78f1e7344bf4/2018-11-06t054310z-1334124005-rc1be15a8050-rtrmadp-3-people-sexiest-man.jpg",
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

  Widget _buildSignupButton() {
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

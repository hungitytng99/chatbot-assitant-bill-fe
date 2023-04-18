import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/ui/pages/auth/sign_up/sign_up_cubit.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_back_button.dart';
import 'package:ihz_bql/ui/widgets/pickers/app_date_picker.dart';
import 'package:ihz_bql/ui/widgets/pickers/app_identity_date_picker.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_email_input.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_label_text_field.dart';
import 'package:ihz_bql/ui/widgets/textfields/app_password_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _obscureTextController = ObscureTextController(obscureText: true);
  final _identityDateController = DatePickerController(dateTime: null);

  late SignUpCubit _cubit;
  final lstBuilding = ['Hotel', 'Nhà nghỉ', 'kangnam', 'sun'];

  @override
  void initState() {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    _cubit = SignUpCubit(authRepository: authRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<SignUpCubit, SignUpState>(
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
                              child: SvgPicture.asset(
                                AppVectors.icSignUp,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                'Đăng ký tài khoản'.toUpperCase(),
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
                              onChanged: (date) =>
                                  _cubit.changeBornDate(date),
                            ),
                            const SizedBox(height: 16),
                            AppPasswordInput(
                              obscureTextController: _obscureTextController,
                              textEditingController: _passwordController,
                              isRequire: true,
                              onChanged: (value) {
                                _cubit.changePassword(value);
                              },
                            ),
                            const SizedBox(height: 20),
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

  Widget _buildSignupButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocConsumer<SignUpCubit, SignUpState>(
          bloc: _cubit,
          listenWhen: (previous, current) {
            return previous.checkUserStatus != current.checkUserStatus;
          },
          listener: (context, state) {
            if (state.checkUserStatus == LoadStatus.success) {
              _openSignUpOtp();
            }
          },
          buildWhen: (previous, current) => true,
          builder: (context, state) {
            return AppButton(
              title: 'Đăng ký tài khoản'.toUpperCase(),
              isEnable: state.isValidData,
              height: 38,
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
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Đã có tài khoản? ',
              style: TextStyle(fontSize: 14, color: AppColors.textBlack)),
          InkWell(
            onTap: () => Get.back(),
            child: Text('Đăng nhập ngay!',
                style: AppTextStyle.blackS14Regular.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.signInPrimary)),
          )
        ]),
        const SizedBox(height: 24),
      ],
    );
  }

  void _openSignUpOtp() async {
    // VerifyAccountResult result = await Get.to(
    //         () => BlocProvider.value(
    //       value: _cubit,
    //       child: SignUpOTPPage(
    //         token: _cubit.state.token,
    //         phoneNumber: _cubit.state.phone,
    //       ),
    //     ),
    //     popGesture: true);
    // if (result != null) {
    //   // _cubit.signUp(result);
    // }
  }

  void _checkDup() {
    _cubit.checkDuplicateUser();
  }
}

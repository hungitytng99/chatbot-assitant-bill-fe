import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:ihz_bql/configs/env_configs.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/models/params/auth/sign_in_body.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/ui/widgets/buttons/app_button.dart';
import 'package:ihz_bql/ui/widgets/commons/app_snackbar.dart';
import 'package:package_info/package_info.dart';

import '../../../../routers/routers.dart';
import 'sign_in_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  StreamSubscription? _navigationSubscription;
  StreamSubscription? _showMessageSubscription;

  final _emailController = TextEditingController(text: 'demo@gmail.com');
  final _passwordController = TextEditingController(text: 'test');

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscuredText = true;

  late SignInCubit _signInCubit;

  @override
  void initState() {
    final _appCubit = BlocProvider.of<AppCubit>(context);
    final _authRepository = RepositoryProvider.of<AuthRepository>(context);

    _signInCubit = SignInCubit(
      appCubit: _appCubit,
      authRepository: _authRepository,
    );
    super.initState();
    _initPackageInfo();
  }

  @override
  void dispose() {
    _signInCubit.close();
    _emailController.dispose();
    _passwordController.dispose();
    _showMessageSubscription?.cancel();
    _navigationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: () async {
            /// TODO: Hiển thị xác nhận thoát ứng dụng
            return false;
          },
          child: BlocListener<SignInCubit, SignInState>(
            bloc: _signInCubit,
            listenWhen: (prev, current) {
              return prev.signInStatus != current.signInStatus;
            },
            listener: (context, state) {
              if (state.signInStatus == LoadStatus.success) {
                Application.router.navigateTo(
                  context,
                  Routes.home,
                  routeSettings: RouteSettings(
                    arguments: HomePageArgument(pageIndex: 0),
                  ),
                );
              }

              if (state.signInStatus == LoadStatus.failure) {
                AppSnackbar.showError(
                    title: 'Đăng nhập thất bại',
                    message: 'Email hoặc mật khẩu không chính xác!');
              }
            },
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      buildWhen: (prev, current) {
        return (prev.signInStatus != current.signInStatus) ||
            (prev.email != current.email) ||
            (prev.password != current.password);
      },
      builder: (context, state) {
        final isLoading = state.signInStatus == LoadStatus.loading;
        return Container(
          margin: const EdgeInsets.only(top: AppDimens.marginS31),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingS28),
          child: AppButton(
            title: 'ĐĂNG NHẬP',
            height: 38,
            cornerRadius: 25,
            backgroundColor: AppColors.signInPrimary,
            onPressed: isLoading
                ? null
                : () {
                    _removeFocus();
                    _signInCubit.signIn(
                        body: SignInBody(
                      username: _emailController.text,
                      password: _passwordController.text,
                    ));
                  },
            isLoading: isLoading,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Positioned.fill(
            child: SvgPicture.asset(
          AppVectors.icSignInBg,
          fit: BoxFit.cover,
        )),
        _buildInput(),
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          // padding: EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNoHaveAccount(),
              const SizedBox(height: 20),
              Text(
                AppConfigs.env == Environment.prod
                    ? "Phiên bản ${_packageInfo.version}"
                    : "Phiên bản ${AppConfigs.envName}-${_packageInfo.version}(${_packageInfo.buildNumber})",
                textAlign: TextAlign.center,
                style: AppTextStyle.blackS14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInput() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              _buildLogo(),
              const SizedBox(height: 30),
              _buildEmailLabel(),
              _buildEmailInput(),
              const SizedBox(height: 28),
              _buildPasswordLabel(),
              _buildPasswordInput(),
              _buildSignButton(),
              const SizedBox(height: 14),
              _buildTextForgotPass(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.marginS28),
      child: Text(
        'Email hoặc số điện thoại',
        style: AppTextStyle.blackS12,
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.marginS28),
      child: TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        cursorColor: AppColors.primary,
        style: AppTextStyle.blackS16,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: '',
          contentPadding: EdgeInsets.only(
              top: AppDimens.paddingS6, bottom: AppDimens.paddingS11),
          isDense: true,
        ),
        onSubmitted: (text) {
          // FocusScope.of(context).requestFocus(_passwordFocusNode);
          _passwordFocusNode.requestFocus();
        },
      ),
    );
  }

  Widget _buildPasswordLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.marginS28),
      child: Text(
        'Mật khẩu',
        style: AppTextStyle.blackS12,
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.marginS28),
      child: TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        textInputAction: TextInputAction.done,
        obscureText: _obscuredText,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        cursorColor: AppColors.primary,
        style: AppTextStyle.blackS16,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: '',
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 38, maxWidth: 38),
          suffixIcon: GestureDetector(
            onTap: _toggle,
            child: Container(
              height: 34,
              width: 38,
              color: AppColors.white,
              alignment: Alignment.centerRight,
              child: _obscuredText
                  ? Image.asset(
                      'assets/images/ic_eye_close.png',
                      fit: BoxFit.fitWidth,
                      width: 18,
                      height: 24,
                    )
                  : Image.asset(
                      'assets/images/ic_eye_open.png',
                      fit: BoxFit.fitWidth,
                      width: 18,
                      height: 24,
                    ),
            ),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.only(top: 6, bottom: 11),
        ),
      ),
    );
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  Widget _buildTextForgotPass() {
    return GestureDetector(
      onTap: () {
        _removeFocus();
      },
      child: Text(
        'Quên mật khẩu?',
        style: AppTextStyle.blackS14,
      ),
    );
  }

  _buildLogo() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 72),
          SvgPicture.asset(AppVectors.icLogo, width: 164, height: 100),
          const SizedBox(height: 72),
        ],
      ),
    );
  }

  Widget _buildNoHaveAccount() {
    return GestureDetector(
      onTap: () {
        Application.router.navigateTo(context, Routes.signUp);
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Chưa có tài khoản? ',
            style: AppTextStyle.blackS14Regular,
          ),
          TextSpan(
            text: 'Đăng ký',
            style: AppTextStyle.tintS14Bold.copyWith(
                decoration: TextDecoration.underline,
                color: AppColors.textTint),
          )
        ]),
      ),
    );
  }

  void _removeFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}

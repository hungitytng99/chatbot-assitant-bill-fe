import 'dart:async';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/blocs/setting/app_setting_cubit.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:ihz_bql/configs/env_configs.dart';
import 'package:ihz_bql/ui/pages/splash/splash_cubit.dart';
import 'package:ihz_bql/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit _cubit;
  late AppSettingCubit _settingCubit;
  StreamSubscription? _navigationSubscription;

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

  @override
  void initState() {
    final appCubit = BlocProvider.of<AppCubit>(context);
    _cubit = SplashCubit(
      appCubit: appCubit,
    );
    _settingCubit = BlocProvider.of<AppSettingCubit>(context);
    _cubit.onInit();
    super.initState();
    _initPackageInfo();
    _setup();
    _settingCubit.initSetting();
  }

  void _setup() async {
    await Future.delayed(const Duration(seconds: 1));
    //Request permission
    // await _firebaseMessaging.requestPermission();
    await Permission.photos.request();
    await Permission.camera.request();
    await Permission.storage.request();
    _initialSetup();
  }

  void _initialSetup() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission();
    }
    String? token = await FirebaseMessaging.instance.getToken();
    logger.d('FCM Token: $token');
    _cubit.checkLogin();
  }

  @override
  void dispose() {
    _navigationSubscription?.cancel();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.appBarGradientTop,
                AppColors.appBarGradientBottom,
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppVectors.bgSplash,
              width: 188,
              height: 115,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin:
                        const EdgeInsets.only(bottom: AppDimens.marginLarge),
                    child: Visibility(
                      visible: _packageInfo.version != 'Unknown',
                      child: Text(
                        AppConfigs.env == Environment.prod
                            ? "Phiên bản ${_packageInfo.version}"
                            : "Phiên bản ${AppConfigs.envName}-${_packageInfo.version}(${_packageInfo.buildNumber})",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.whiteS16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

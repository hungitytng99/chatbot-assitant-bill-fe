import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/blocs/navigation/navigation_cubit.dart';
import 'package:ihz_bql/blocs/setting/app_setting_cubit.dart';
import 'package:ihz_bql/common/app_theme.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/repositories/user_repository.dart';
import 'package:ihz_bql/routers/application.dart';
import 'package:ihz_bql/routers/navigation_observer.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'generated/l10n.dart';
import 'networks/api_client.dart';
import 'networks/api_util.dart';
import 'package:ihz_bql/repositories/expert_repository.dart';

final appNavigatorKey = GlobalKey<NavigatorState>();

Future initApp() async {
  await Firebase.initializeApp();

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  // await AddressUtils.instance.load();
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;
  NavigationCubit? _navigationCubit;

  @override
  void initState() {
    _apiClient = ApiUtil.getApiClient();
    _navigationCubit = NavigationCubit();
    super.initState();
  }

  @override
  void dispose() {
    _navigationCubit!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryImpl(_apiClient);
        }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl(_apiClient);
        }),
        RepositoryProvider<ExpertRepository>(create: (context) {
          return ExpertRepositoryImpl(_apiClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final _userRepository =
                RepositoryProvider.of<UserRepository>(context);
            final _authRepository =
                RepositoryProvider.of<AuthRepository>(context);
            return AppCubit(
              userRepository: _userRepository,
              authRepository: _authRepository,
            );
          }),
          BlocProvider<AppSettingCubit>(create: (context) {
            return AppSettingCubit();
          }),
        ],
        child: materialApp(),
      ),
    );
  }

  Widget materialApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return GetMaterialApp(
      navigatorKey: appNavigatorKey,
      onGenerateRoute: Application.router.generator,
      initialRoute: Routes.root,
      navigatorObservers: <NavigatorObserver>[
        NavigationObserver(navigationCubit: _navigationCubit),
      ],
      title: AppConfigs.appName,
      theme: const AppTheme().toThemeData(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
            /*if (Platform.isIOS) */
            hideKeyboard(context);
          },
          child: MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          ),
        );
      },
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

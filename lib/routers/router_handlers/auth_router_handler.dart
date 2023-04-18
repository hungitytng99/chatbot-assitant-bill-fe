import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/ui/pages/auth/sign_in/sign_in_cubit.dart';
import 'package:ihz_bql/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:ihz_bql/ui/pages/auth/sign_up/sign_up_cubit.dart';
import 'package:ihz_bql/ui/pages/auth/sign_up/sign_up_page.dart';
import 'package:ihz_bql/ui/pages/splash/splash_cubit.dart';
import 'package:ihz_bql/ui/pages/splash/splash_page.dart';

Handler splashHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (BuildContext context) {
      final _appCubit = BlocProvider.of<AppCubit>(context);
      return SplashCubit(appCubit: _appCubit);
    },
    child: const SplashPage(),
  );
});

Handler signInHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (BuildContext context) {
      final authRepository = RepositoryProvider.of<AuthRepository>(context);
      final _appCubit = BlocProvider.of<AppCubit>(context);
      return SignInCubit(appCubit: _appCubit, authRepository: authRepository);
    },
    child: const SignInPage(),
  );
});

Handler signUpHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (BuildContext context) {
      final authRepository = RepositoryProvider.of<AuthRepository>(context);
      return SignUpCubit(authRepository: authRepository);
    },
    child: const SignUpPage(),
  );
});

import 'package:ihz_bql/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:ihz_bql/ui/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteConfig {
  ///main page
  static const String splash = "/splash";
  static const String main = "/main";
  static const String signIn = "/signIn";
  static const String buildingPicker = "/buildingPicker";

  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
  ];
}

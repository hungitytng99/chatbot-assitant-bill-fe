import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/database/share_preferences_helper.dart';
import 'package:ihz_bql/globals/global_data.dart';
import 'package:ihz_bql/models/entities/auth_token_entity.dart';
import 'package:ihz_bql/models/entities/user_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/repositories/user_repository.dart';
import 'package:ihz_bql/routers/routers.dart';
import 'package:ihz_bql/ui/pages/homepage/home_page.dart';
import 'package:ihz_bql/ui/widgets/commons/app_dialog.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  AppCubit appCubit;
  UserRepository userRepository;

  SplashCubit({
    required this.appCubit,
    required this.userRepository,
  }) : super(const SplashState());

  void checkLogin() async {
    String? token = await SharedPreferencesHelper.getApiTokenKey();
    if (token.isEmpty) {
      _openSignInPage();
    } else {
      try {
        GlobalData.instance.token = AuthTokenEntity(
          accessToken: token,
          tokenType: 'bearer',
        );
        UserEntity myProfile = await userRepository.getMyProfile();
        appCubit.updateMyProfile(userEntity: myProfile);
        _openHomePage();
      } catch (error) {
        SharedPreferencesHelper.removeApiTokenKey();
        _openSignInPage();
      }
    }
  }

  void onInit() async {}

  ///Navigate
  void _openSignInPage() {
    Get.offAndToNamed(Routes.signIn);
  }

  void _openHomePage() {
    Get.offAndToNamed(Routes.home, arguments: HomePageArgument(pageIndex: 0));
  }
}

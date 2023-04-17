import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/routers/route_config.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  AppCubit appCubit;

  SplashCubit({
    required this.appCubit,
  }) : super(SplashState());

  void checkLogin() async {
    _openSignInPage();
    // TokenEntity? token = await authRepository.getToken();
    //
    // if (token == null) {
    //   logger.d('emit LOGGED_OUT');
    //   _openSignInPage();
    // } else {
    //   try {
    //     GlobalData.instance.token = token;
    //     //Profile
    //     UserEntity myProfile = await userRepository.getProfile();
    //
    //     //Role
    //     final roleUser = await userRepository.getUserRole(myProfile.id ?? "");
    //     GlobalData.instance.userRole = roleUser;
    //
    //     _openMainPage();
    //   } catch (error) {
    //     //Check 401
    //     if (error is DioError) {
    //       if (error.response?.statusCode == 401) {
    //         authRepository.removeToken();
    //         checkLogin();
    //         return;
    //       }
    //     }
    //
    //     emit(state.copyWith(loginState: LoadStatus.failure));
    //     AppDialog.defaultDialog(
    //       title: 'Đã xảy ra lỗi',
    //       message: 'Lỗi không thể kết nối, xin vui vòng kiểm tra lại',
    //       textConfirm: 'Thử lại',
    //       onConfirm: () {
    //         checkLogin();
    //       },
    //     );
    //   }
    // }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void onInit() async {
  }

  ///Navigate
  void _openSignInPage() {
    Get.offAndToNamed(RouteConfig.signIn);
  }
}


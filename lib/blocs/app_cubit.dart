import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/globals/global_data.dart';
import 'package:ihz_bql/models/entities/index.dart';
import 'package:ihz_bql/models/entities/token_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/repositories/user_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AuthRepository authRepository;
  UserRepository userRepository;

  // late SocketIO _socket;
  AppCubit({required this.authRepository, required this.userRepository})
      : super(const AppState());

  void removeUserSection() {
    GlobalData.instance.token = null;
  }

  ///Sign Out
  void signOut() async {
    // emit(state.copyWith(signOutStatus: LoadStatus.loading));
    // try {
    //   // final deviceToken = await FirebaseMessaging.instance.getToken();
    //   final param = SignOutParam(deviceToken: "");
    //   await authRepository.signOut(param);
    //   // await FirebaseMessaging.instance.deleteToken();
    //   await authRepository.removeToken();
    //   GlobalData.instance.token = null;
    //   GlobalData.instance.building.value = null;
    //
    //   await SharedPreferencesHelper.saveBuildingInfo(building: null);
    //   emit(state.copyWith(building: null));
    //   AppColors.configFromRemote();
    //   Get.changeTheme(AppTheme(
    //     primaryColor: AppColors.primary,
    //     secondaryColor: AppColors.secondary,
    //   ).toThemeData());
    //
    //   emit(state.copyWith(signOutStatus: LoadStatus.success));
    // } catch (e) {
    //   logger.e(e);
    //   emit(state.copyWith(signOutStatus: LoadStatus.failure));
    // }
  }
}

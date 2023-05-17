import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/database/share_preferences_helper.dart';
import 'package:ihz_bql/globals/global_data.dart';
import 'package:ihz_bql/models/entities/auth_token_entity.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/auth/sign_in_body.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

part 'sign_in_state.dart';

enum SignInNavigator {
  OPEN_HOME,
}

class SignInCubit extends Cubit<SignInState> {
  AppCubit appCubit;
  AuthRepository authRepository;

  SignInCubit({
    required this.appCubit,
    required this.authRepository,
  }) : super(const SignInState());

  void signIn({
    required SignInBody body,
  }) async {
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      final AuthTokenEntity result = await authRepository.signIn(body);
      SharedPreferencesHelper.setApiTokenKey(
          "${result.tokenType} ${result.accessToken}");
      GlobalData.instance.token = result;
      emit(state.copyWith(
        signInStatus: LoadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

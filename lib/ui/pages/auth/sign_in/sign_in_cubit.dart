import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/blocs/app_cubit.dart';
import 'package:ihz_bql/models/entities/index.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/utils/validator_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }) : super(SignInState());

  @override
  Future<void> close() {
    return super.close();
  }

}

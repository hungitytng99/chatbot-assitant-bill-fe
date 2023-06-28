import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/models/params/auth/sign_up_body.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(const SignUpState());

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> signUp() async {
    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      await authRepository.signUp(SignUpBody(
        fullName: state.name,
        password: state.password,
        username: state.email,
      ));
      emit(state.copyWith(
        signUpStatus: LoadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(signUpStatus: LoadStatus.failure));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

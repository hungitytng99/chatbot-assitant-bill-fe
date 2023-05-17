import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/repositories/auth_repository.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository}) : super(const SignUpState());

  Future<void> checkUser(String phone) async {

  }

  // Future<void> signUp(VerifyAccountResult acc) async {
  //
  // }

  Future checkDuplicateUser() async {

  }

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void changeBornDate(DateTime datetime) {
    emit(state.copyWith(bornDate: datetime));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

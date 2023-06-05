import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ihz_bql/models/enums/load_status.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(const UpdateProfileState());

  Future<void> checkUser(String phone) async {}

  // Future<void> signUp(VerifyAccountResult acc) async {
  //
  // }

  Future checkDuplicateUser() async {}

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }


  @override
  Future<void> close() {
    return super.close();
  }
}

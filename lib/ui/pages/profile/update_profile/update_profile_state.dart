part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String token;
  final DateTime? bornDate;
  final LoadStatus signUpStatus;
  final LoadStatus checkUserStatus;
  final LoadStatus confirmStatus;

  const UpdateProfileState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.bornDate,
    this.token = "",
    this.signUpStatus = LoadStatus.initial,
    this.checkUserStatus = LoadStatus.initial,
    this.confirmStatus = LoadStatus.initial,
  });

  bool get isValidData {
    return name.trim().isNotEmpty &&
        //fix lỗi sử dụng validator password cho số điện thoại
        bornDate != null &&
        ValidatorUtils.validateEmail(email) &&
        ValidatorUtils.validatePassword(password);
  }

  UpdateProfileState copyWith({
    String? name,
    String? email,
    String? password,
    String? token,
    DateTime? bornDate,
    LoadStatus? signUpStatus,
    LoadStatus? checkUserStatus,
    LoadStatus? confirmStatus,
  }) {
    return UpdateProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      password: password ?? this.password,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      bornDate: bornDate ?? this.bornDate,
      checkUserStatus: checkUserStatus ?? this.checkUserStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        signUpStatus,
        bornDate,
        checkUserStatus,
        token,
        confirmStatus,
        isValidData,
      ];
}

part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String token;
  final DateTime? bornDate;
  final LoadStatus signUpStatus;
  final LoadStatus checkUserStatus;
  final LoadStatus confirmStatus;

  const SignUpState({
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
        ValidatorUtils.validateEmail(email) &&
        password.trim().isNotEmpty;
  }

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? token,
    DateTime? bornDate,
    LoadStatus? signUpStatus,
    LoadStatus? checkUserStatus,
    LoadStatus? confirmStatus,
  }) {
    return SignUpState(
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

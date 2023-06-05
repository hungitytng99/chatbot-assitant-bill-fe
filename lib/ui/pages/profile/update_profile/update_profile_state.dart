part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final String name;
  final String email;
  final String token;
  final LoadStatus signUpStatus;
  final LoadStatus checkUserStatus;
  final LoadStatus confirmStatus;

  const UpdateProfileState({
    this.name = "",
    this.email = "",
    this.token = "",
    this.signUpStatus = LoadStatus.initial,
    this.checkUserStatus = LoadStatus.initial,
    this.confirmStatus = LoadStatus.initial,
  });

  bool get isValidData {
    return name.trim().isNotEmpty && ValidatorUtils.validateEmail(email);
  }

  UpdateProfileState copyWith({
    String? name,
    String? email,
    String? password,
    String? token,
    LoadStatus? signUpStatus,
    LoadStatus? checkUserStatus,
    LoadStatus? confirmStatus,
  }) {
    return UpdateProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      checkUserStatus: checkUserStatus ?? this.checkUserStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        signUpStatus,
        checkUserStatus,
        token,
        confirmStatus,
        isValidData,
      ];
}

part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final TokenEntity? token;
  final LoadStatus signInStatus;
  final String emailOrPhone;
  final String password;
  final SharedPreferences? prefs;
  final LoadStatus? sharedPreferenceStatus;
  final LoadStatus? fetchBuildingStatus;

  const SignInState({
    this.token,
    this.signInStatus = LoadStatus.initial,
    this.fetchBuildingStatus = LoadStatus.initial,
    this.emailOrPhone = "",
    this.password = "",
    this.prefs,
    this.sharedPreferenceStatus,
  });

  bool get isValid {
    if (isValidEmail || isValidPhone) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidEmail {
    return ValidatorUtils.validateEmail(emailOrPhone);
  }

  bool get isValidPhone {
    return ValidatorUtils.validatePhone(emailOrPhone);
  }

  SignInState copyWith({
    TokenEntity? token,
    LoadStatus? signInStatus,
    String? emailOrPhone,
    String? password,
    SharedPreferences? prefs,
    LoadStatus? sharedPreferenceStatus,
    LoadStatus? fetchBuildingStatus,
  }) {
    return SignInState(
      token: token ?? this.token,
      signInStatus: signInStatus ?? this.signInStatus,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      password: password ?? this.password,
      prefs: prefs ?? this.prefs,
      fetchBuildingStatus: fetchBuildingStatus ?? this.fetchBuildingStatus,
      sharedPreferenceStatus:
          sharedPreferenceStatus ?? this.sharedPreferenceStatus,
    );
  }

  @override
  List<Object?> get props => [
        token,
        signInStatus,
        emailOrPhone,
        password,
        prefs,
        fetchBuildingStatus,
        sharedPreferenceStatus
      ];
}

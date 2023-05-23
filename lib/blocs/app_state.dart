part of 'app_cubit.dart';

class AppState extends Equatable {
  final AuthTokenEntity? token;
  final LoadStatus? signOutStatus;
  final UserEntity? userEntity;

  const AppState({
    this.token,
    this.signOutStatus,
    this.userEntity,
  });

  AppState copyWith({
    AuthTokenEntity? token,
    LoadStatus? signOutStatus,
    UserEntity? userEntity,
  }) {
    return AppState(
      token: token ?? this.token,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  List<Object?> get props => [
        token,
        signOutStatus,
        userEntity,
      ];
}

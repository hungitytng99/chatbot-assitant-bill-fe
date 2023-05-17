part of 'app_cubit.dart';

class AppState extends Equatable {
  final AuthTokenEntity? token;
  final LoadStatus? signOutStatus;

  const AppState({
    this.token,
    this.signOutStatus,
  });

  AppState copyWith({
    AuthTokenEntity? token,
    LoadStatus? signOutStatus,
  }) {
    return AppState(
      token: token ?? this.token,
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  @override
  List<Object?> get props => [
        token,
        signOutStatus,
      ];
}

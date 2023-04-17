part of 'app_cubit.dart';

class AppState extends Equatable {
  final TokenEntity? token;
  final LoadStatus? signOutStatus;

  const AppState({
    this.token,
    this.signOutStatus,
  });

  AppState copyWith({
    TokenEntity? token,
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

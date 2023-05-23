part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final LoadStatus loginState;
  final LoadStatus loadUserStatus;
  final LoadStatus loadServerConfigStatus;

  const SplashState({
    this.loginState = LoadStatus.initial,
    this.loadUserStatus = LoadStatus.initial,
    this.loadServerConfigStatus = LoadStatus.initial,
  });

  SplashState copyWith({
    LoadStatus? loginState,
    LoadStatus? loadUserStatus,
    LoadStatus? loadServerConfigStatus,
  }) {
    return SplashState(
      loginState: loginState ?? this.loginState,
      loadUserStatus: loadUserStatus ?? this.loadUserStatus,
      loadServerConfigStatus:
          loadServerConfigStatus ?? this.loadServerConfigStatus,

    );
  }

  @override
  List<Object?> get props => [
        loginState,
        loadUserStatus,
        loadServerConfigStatus,
      ];
}

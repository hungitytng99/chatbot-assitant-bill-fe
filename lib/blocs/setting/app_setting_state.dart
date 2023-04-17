part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final Locale currentLocate;

  const AppSettingState({
    this.currentLocate = const Locale.fromSubtags(languageCode: "vi"),
  });

  @override
  List<Object?> get props => [
        currentLocate,
      ];

  AppSettingState copyWith({
    Locale? currentLocate,
  }) {
    return AppSettingState(
      currentLocate: currentLocate ?? this.currentLocate,
    );
  }
}

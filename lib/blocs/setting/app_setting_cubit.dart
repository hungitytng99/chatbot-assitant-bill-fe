import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  void initSetting() async {
    final prefs = await SharedPreferences.getInstance();

    ///Language
    // String languageCode =
    //     prefs.getString("languageCode") ?? window.locale.languageCode;
    String languageCode =
        prefs.getString("languageCode") ?? "vi";
    var locale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == languageCode,
      orElse: () => const Locale.fromSubtags(languageCode: "vi"),
    );
    emit(state.copyWith(currentLocate: locale));
    Get.updateLocale(state.currentLocate);
  }

  void updateLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    var newLocale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == locale.languageCode,
      orElse: () => const Locale.fromSubtags(languageCode: "vi"),
    );
    prefs.setString('languageCode', newLocale.languageCode);
    emit(state.copyWith(currentLocate: newLocale));
    Get.updateLocale(state.currentLocate);
  }
}

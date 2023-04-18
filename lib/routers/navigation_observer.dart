import 'package:flutter/widgets.dart';
import 'package:ihz_bql/blocs/navigation/navigation_cubit.dart';

String? defaultNameExtractor(RouteSettings settings) => settings.name;

class NavigationObserver extends RouteObserver<PageRoute<dynamic>> {
  final Function nameExtractor;
  final NavigationCubit? navigationCubit;
  NavigationObserver({
    required this.navigationCubit,
    this.nameExtractor = defaultNameExtractor,
  });

  void _sendScreenView(PageRoute<dynamic> route) {
    final String? screenName = nameExtractor(route.settings);
    if (screenName != null) {
      navigationCubit!.setCurrentScreen(screenName);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) _removeScreen(previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) _sendScreenView(route);
  }

  void _removeScreen(PageRoute<dynamic> route) {
    final String? screenName = nameExtractor(route.settings);
    if (screenName != null) {
      navigationCubit!.removeCurrentScreen(screenName);
    }
  }
}

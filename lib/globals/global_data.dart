import 'package:flutter/cupertino.dart';
import 'package:ihz_bql/models/entities/auth_token_entity.dart';
import 'package:rxdart/rxdart.dart';

class GlobalData {
  GlobalData._();

  static final GlobalData instance = GlobalData._();

  AuthTokenEntity? token;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final notificationCountController = BehaviorSubject<int>.seeded(0);


}

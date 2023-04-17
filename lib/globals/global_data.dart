import 'package:flutter/cupertino.dart';
import 'package:ihz_bql/models/entities/index.dart';
import 'package:ihz_bql/models/entities/user/user_role_entity.dart';
import 'package:rxdart/rxdart.dart';

class GlobalData {
  GlobalData._();

  static final GlobalData instance = GlobalData._();

  TokenEntity? token;

  ///Removed => try get Profile from AppCubit
  // UserEntity? myProfile;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final notificationCountController = BehaviorSubject<int>.seeded(0);


}

import 'dart:async';

import 'package:ihz_bql/models/entities/index.dart';

class GlobalEvent {
  GlobalEvent._privateConstructor();

  static final GlobalEvent instance = GlobalEvent._privateConstructor();

  // ignore: close_sinks
  final onTokenExpired = StreamController<bool>.broadcast();
}

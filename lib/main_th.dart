import 'package:flutter/material.dart';

import 'app.dart';
import 'configs/app_configs.dart';
import 'configs/env_configs.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfigs.env = Environment.th;

  /// AWAIT SERVICES INITIALIZATION.
  await initApp();

  runApp(MyApp());
}


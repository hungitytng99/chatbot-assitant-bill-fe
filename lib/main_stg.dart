import 'package:flutter/material.dart';

import 'app.dart';
import 'configs/app_configs.dart';
import 'configs/env_configs.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfigs.env = Environment.stg;

  /// AWAIT SERVICES INITIALIZATION.
  await initApp();

  runApp(const MyApp());
}


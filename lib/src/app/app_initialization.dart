import 'package:flutter/material.dart';

import 'app_controllers.dart';

abstract class AppInitialization {
  static void init() {
    WidgetsFlutterBinding.ensureInitialized();

    AppControllers.init();
  }
}

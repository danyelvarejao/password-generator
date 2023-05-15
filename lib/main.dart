import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/app/app_initialization.dart';
import 'src/app/app_widget.dart';

void main() {
  AppInitialization.init();

  runApp(
    DevicePreview(
      enabled: !kDebugMode,
      builder: (context) => const MyApp(),
    ),
  );
}

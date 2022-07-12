import 'package:flutter/material.dart';
import 'core/core.dart';
import 'package:sample_framework/config/core/AppStoreApplication.dart';

import 'di.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

class Env {
  static late Env value;
  late String appName;
  late String baseUrl;

  EnvType environmentType = EnvType.DEVELOPMENT;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await DenpendencyInjection.init();

    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.STAGING == environmentType) {
      // Stetho.initialize();
    }

    var application = AppStoreApplication();
    await application.onCreate();
    // await Firebase.initializeApp();
    runApp(AppComponent(application));
  }
}

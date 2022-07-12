import 'package:logging/logging.dart';

import '../../app/network/api/network_api.dart';

import 'package:sample_framework/config/env.dart';
import 'package:sample_framework/utility/framework/Application.dart';
import 'package:sample_framework/utility/log/Log.dart';

class AppStoreApplication implements Application {
  late APIRepository appStoreAPIRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    _initAPIRepository();
  }

  void _initAPIRepository() {
    APIProvider apiProvider = APIProvider();
    appStoreAPIRepository = APIRepository(apiProvider: apiProvider);
  }

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:
        {
          Log.setLevel(Level.ALL);
          break;
        }
      case EnvType.PRODUCTION:
        {
          Log.setLevel(Level.INFO);
          break;
        }
    }
  }

  @override
  Future<void> onTerminate() async {}
}

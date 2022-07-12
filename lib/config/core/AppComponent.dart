import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../app/lang/translation_service.dart';
import '../config_base.dart';
import '../core/core.dart';

class AppComponent extends StatefulWidget {
  final AppStoreApplication _application;

  AppComponent(this._application);

  @override
  State createState() {
    return new AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  @override
  void dispose() async {
    super.dispose();
    await widget._application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    final myApp = GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: Env.value.environmentType != EnvType.PRODUCTION,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: Env.value.appName,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      builder: EasyLoading.init(),
    );
    final appProvider =
        AppProvider(child: myApp, application: widget._application);
    return appProvider;
  }
}

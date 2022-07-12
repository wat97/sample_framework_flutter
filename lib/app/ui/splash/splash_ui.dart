import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash.dart';

class SplashUi extends StatelessWidget {
  static const String PATH = '/';

  final SplashLogic logic = Get.find<SplashLogic>();
  final SplashState state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashLogic>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Text('splashScreen'.tr),
        ),
      ),
    );
  }
}

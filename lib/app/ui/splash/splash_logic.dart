import 'dart:async';

import 'package:get/get.dart';
import '../ui.dart';
import 'splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  APIRepository apiRepository;

  var coreData = Get.find<SharedPreferences>();

  SplashLogic({required this.apiRepository});

  @override
  void onInit() {
    print("onInit");
    Timer(Duration(seconds: 4), () {
      print("Splah");
      Get.offNamed(
        ExampleUi.PATH,
      );
    });

    super.onInit();
  }
}

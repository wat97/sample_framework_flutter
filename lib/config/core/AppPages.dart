import 'package:get/get.dart';

import '../../app/ui/ui.dart';

class AppPages {
  static const INITIAL = SplashUi.PATH;
  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => SplashUi(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: ExampleUi.PATH,
      page: () => ExampleUi(),
      binding: ExampleBinding(),
    ),
  ];
}

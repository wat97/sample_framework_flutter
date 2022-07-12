import 'package:get/get.dart';
import 'example_logic.dart';

class ExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExampleLogic(apiRepository: Get.find()));
  }
}

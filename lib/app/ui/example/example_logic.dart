import 'package:get/get.dart';
import '../ui.dart';
import 'example_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExampleLogic extends GetxController {
  final ExampleState state = ExampleState();

  APIRepository apiRepository;

  var coreData = Get.find<SharedPreferences>();

  ExampleLogic({required this.apiRepository});

  @override
  void onInit() {
    print("example");
    super.onInit();
  }
}

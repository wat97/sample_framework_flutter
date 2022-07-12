import 'package:get/get.dart';

import '../app/network/api/network_api.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(APIProvider(), permanent: true);
    Get.put(APIRepository(apiProvider: APIProvider()), permanent: true);
  }
}

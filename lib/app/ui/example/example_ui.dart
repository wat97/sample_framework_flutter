import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'example_logic.dart';
import 'example_state.dart';

class ExampleUi extends StatelessWidget {
  static const String PATH = '/example';

  final ExampleLogic logic = Get.find<ExampleLogic>();
  final ExampleState state = Get.find<ExampleLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExampleLogic>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Text("hello"),
        ),
      ),
    );
  }
}

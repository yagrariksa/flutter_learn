import 'package:flutter_learn/calculatorController.dart';
import 'package:get/instance_manager.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculatorController());
  }
}

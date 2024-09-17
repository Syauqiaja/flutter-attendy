import 'package:attendy_flutter/modules/authentication/register/controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController()
    );
  }
}
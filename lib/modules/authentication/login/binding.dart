import 'package:attendy_flutter/modules/authentication/login/controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController()
    );
  }
}
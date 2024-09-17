import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

  final registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPassController = TextEditingController();
  final isPassObscure = true.obs;
  final isConfirmPassObscure = true.obs;
  final isLoading = false.obs;

  registerUser() async {
    isLoading.value = true;
    User? user = await _userRepository.signUp(
      emailController.text,
      passController.text,
      nameController.text,
    );
    isLoading.value = false;
    if (user != null) {
      Get.offAllNamed("/");
    }
  }
}

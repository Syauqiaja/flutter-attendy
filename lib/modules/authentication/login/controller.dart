import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final isPassObscure = true.obs;
  final isLoading = false.obs;

  login() async {
    isLoading.value = true;
    User? user = await _userRepository.signIn(
      emailController.text,
      passController.text,
    );
    isLoading.value = false;
    if (user != null) {
      Get.offAllNamed("/");
    }
  }

  loginWithGoogle() async{
    isLoading.value = true;
    UserCredential? user = await _userRepository.signInWithGoogle();
    isLoading.value = false;
    if(user != null){
      Get.offAllNamed("/");
    }
  }
}

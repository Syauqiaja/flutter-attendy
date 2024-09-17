import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/modules/authentication/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColor.white,
      body: Form(
        key: controller.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/illust_login.png',
                width: 250,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    cursorColor: StyleColor.primary,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: StyleColor.white_2,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: StyleColor.primary.withOpacity(0),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return TextFormField(
                      obscureText: controller.isPassObscure.value,
                      controller: controller.passController,
                      cursorColor: StyleColor.primary,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: StyleColor.white_2,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: StyleColor.primary.withOpacity(0),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // Here is key idea
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            controller.isPassObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[500],
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            controller.isPassObscure.value =
                                !controller.isPassObscure.value;
                          },
                        ),
                        hintText: 'Password',
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.6)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return Container(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: StyleColor.primary),
                        onPressed: () {
                          if (controller.loginFormKey.currentState!
                                  .validate() &&
                              !controller.isLoading.value) {
                            controller.login();
                          }
                        },
                        child: controller.isLoading.value
                            ? CircularProgressIndicator()
                            : Text(
                                "Login",
                                style: TextStyle(
                                    color: StyleColor.white, fontSize: 16),
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: Get.width,
                    height: 50,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: StyleColor.primary),
                          backgroundColor: StyleColor.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          controller.loginWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ic_google.png",
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Login with Google",
                              style: TextStyle(
                                  color: StyleColor.black, fontSize: 16),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Center(
                    child: Text("Don't have any account?"),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed("/register");
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: StyleColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

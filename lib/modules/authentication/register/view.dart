import 'package:attendy_flutter/modules/authentication/register/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendy_flutter/core/values/colors.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColor.white,
      body: Form(
        key: controller.registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Registration Form",
              style: TextStyle(
                  color: StyleColor.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            )),
            SizedBox(
              height: 30,
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
                    controller: controller.nameController,
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
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.emailController,
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
                  const SizedBox(height: 16),
                  Obx(() {
                    return TextFormField(
                      obscureText: controller.isPassObscure.value,
                      controller: controller.passController,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPassObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[500],
                          ),
                          onPressed: () {
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
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  Obx(() {
                    return TextFormField(
                      controller: controller.confirmPassController,
                      obscureText: controller.isConfirmPassObscure.value,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPassObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[500],
                          ),
                          onPressed: () {
                            controller.isConfirmPassObscure.value =
                                !controller.isConfirmPassObscure.value;
                          },
                        ),
                        hintText: 'Confirm Password',
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.6)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != controller.passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  Obx(() {
                    return Container(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: StyleColor.primary,
                        ),
                        onPressed: () {
                          if ((controller.registerFormKey.currentState
                                      ?.validate() ??
                                  false) &&
                              !controller.isLoading.value) {
                            // Handle registration logic
                            controller.registerUser();
                          }
                        },
                        child: controller.isLoading.value
                            ? CircularProgressIndicator()
                            : Text(
                                "Register",
                                style: TextStyle(
                                    color: StyleColor.white, fontSize: 16),
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                  const Center(
                    child: Text("Already have an account?"),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Login",
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
            ),
          ],
        ),
      ),
    );
  }
}

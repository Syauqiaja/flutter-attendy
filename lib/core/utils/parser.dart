import 'package:attendy_flutter/modules/fill_attendance/widgets/failed_dialog.dart';
import 'package:attendy_flutter/modules/fill_attendance/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showFailedDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FailedDialog(title: title, description: message);
      },
    );
  }
  void showSucceSsDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(title: title, onComplete: (){
          Get.back();
        },);
      },
    );
  }
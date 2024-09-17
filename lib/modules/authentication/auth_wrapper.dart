import 'package:attendy_flutter/data/services/firebase_service.dart';
import 'package:attendy_flutter/modules/authentication/login/controller.dart';
import 'package:attendy_flutter/modules/authentication/login/view.dart';
import 'package:attendy_flutter/modules/home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthWrapper extends StatelessWidget {
  final FirebaseAuthenticationService authService =
      Get.find<FirebaseAuthenticationService>();
  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }else if(snapshot.hasData){
          return HomePage();
        }else{
          return LoginPage();
        }
      },
    );
  }
}

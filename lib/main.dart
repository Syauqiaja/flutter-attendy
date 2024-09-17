import 'package:attendy_flutter/data/services/firebase_service.dart';
import 'package:attendy_flutter/data/services/storage_services.dart';
import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:attendy_flutter/modules/authentication/auth_wrapper.dart';
import 'package:attendy_flutter/modules/authentication/login/binding.dart';
import 'package:attendy_flutter/modules/authentication/login/controller.dart';
import 'package:attendy_flutter/modules/authentication/login/view.dart';
import 'package:attendy_flutter/modules/authentication/register/binding.dart';
import 'package:attendy_flutter/modules/authentication/register/controller.dart';
import 'package:attendy_flutter/modules/authentication/register/view.dart';
import 'package:attendy_flutter/modules/fill_attendance/binding.dart';
import 'package:attendy_flutter/modules/fill_attendance/view.dart';
import 'package:attendy_flutter/modules/home/binding.dart';
import 'package:attendy_flutter/modules/home/view.dart';
import 'package:attendy_flutter/modules/location/add_location/binding.dart';
import 'package:attendy_flutter/modules/location/add_location/view.dart';
import 'package:attendy_flutter/modules/location/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  Get.put(FirebaseAuthenticationService());
  Get.put(UserRepository());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => RegisterController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Attendy',
      theme: ThemeData(),
      home: AuthWrapper(),
      initialRoute: "/",
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(
          name: "/login",
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: "/register",
          page: () => RegisterPage(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: "/",
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: "/attend",
          page: () => FillAttendancePage(),
          binding: FillAttendanceBinding(),
        ),
        GetPage(
          name: "/location",
          page: () => DetailPage(),
        ),
        GetPage(
          name: "/location/add",
          page: () => AddLocationPage(),
          binding: AddLocationBinding(),
        ),
      ],
    );
  }
}

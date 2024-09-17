import 'package:attendy_flutter/data/providers/storage_provider.dart';
import 'package:attendy_flutter/data/repositories/attendance_repository.dart';
import 'package:attendy_flutter/data/repositories/place_repository.dart';
import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:attendy_flutter/modules/fill_attendance/controller.dart';
import 'package:attendy_flutter/modules/home/controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        userRepository: UserRepository(),
        attendanceRepository: AttendanceRepository(
          storageProvider: StorageProvider(),
        ),
        placeRepository: PlaceRepository(
          storageProvider: StorageProvider(),
        ),
      ),
    );
  }
}

import 'package:attendy_flutter/data/providers/storage_provider.dart';
import 'package:attendy_flutter/data/repositories/attendance_repository.dart';
import 'package:attendy_flutter/data/repositories/place_repository.dart';
import 'package:attendy_flutter/data/repositories/user_repository.dart';
import 'package:attendy_flutter/modules/fill_attendance/controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class FillAttendanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillAttendanceController>(() => FillAttendanceController(
          userRepository: UserRepository(),
          placeRepository: PlaceRepository(
            storageProvider: StorageProvider(),
          ),
          attendanceRepository: AttendanceRepository(
            storageProvider: StorageProvider(),
          ),
        ));
  }
}

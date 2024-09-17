import 'package:attendy_flutter/data/providers/storage_provider.dart';
import 'package:attendy_flutter/data/repositories/place_repository.dart';
import 'package:attendy_flutter/modules/location/add_location/controller.dart';
import 'package:get/get.dart';

class AddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLocationController>(
      () => AddLocationController(
        placeRepository: PlaceRepository(storageProvider: StorageProvider(),),
      ),
    );
  }
}

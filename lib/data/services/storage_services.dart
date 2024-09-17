import 'dart:ffi';

import 'package:attendy_flutter/core/utils/keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    _box.listen(() => print("StorageService: GetStorage changed"));
    _box.listenKey(attendanceKey, (val) => print("Changes: $val"));
    await _box.writeIfNull(attendanceKey, []);
    await _box.writeIfNull(placeKey, []);
    await _box.writeIfNull(selectedPlace, []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}

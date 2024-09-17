import 'package:attendy_flutter/data/models/attendance.dart';
import 'package:attendy_flutter/data/providers/storage_provider.dart';

class AttendanceRepository {
  StorageProvider storageProvider;
  AttendanceRepository({required this.storageProvider});

  List<Attendance> readAttendances() => storageProvider.readAttendances();
  List<Attendance> readUserAttendances(String uid) => storageProvider.readUserAttendances(uid);
  void writeAttendances(List<Attendance> attendances) => storageProvider.writeAttendances(attendances);
}

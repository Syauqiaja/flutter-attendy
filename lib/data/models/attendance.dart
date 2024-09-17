import 'package:equatable/equatable.dart';

class Attendance extends Equatable{
  final String userId;
  final int placeId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;

  Attendance({
    required this.userId,
    required this.placeId,
    required this.checkInTime,
    this.checkOutTime,
  });

  Attendance copyWith({
    String? userId,
    int? officeId,
    DateTime? checkInTime,
    DateTime? checkOutTime,
  }) =>
      Attendance(
        userId: userId ?? this.userId,
        placeId: officeId ?? this.placeId,
        checkInTime: checkInTime ?? this.checkInTime,
        checkOutTime: checkOutTime ?? this.checkOutTime,
      );

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        userId: json['userId'],
        placeId: int.parse(json['officeId'].toString()),
        checkInTime: DateTime.parse(json['checkInTime']),
        checkOutTime: json.containsKey('checkOutTime') && json['checkOutTime'] != null
            ? DateTime.parse(json['checkOutTime'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'officeId': placeId,
        'checkInTime': checkInTime.toIso8601String(),
        'checkOutTime': checkOutTime?.toIso8601String(),
      };

  @override
  List<Object?> get props => [userId, placeId, checkInTime, checkOutTime];
}

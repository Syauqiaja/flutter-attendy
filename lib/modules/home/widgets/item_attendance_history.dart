import 'package:attendy_flutter/core/values/colors.dart';
import 'package:attendy_flutter/data/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemAttendanceHistory extends StatelessWidget {
  final Attendance attendance;
  const ItemAttendanceHistory({required this.attendance, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 55,
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: StyleColor.primary, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("dd").format(attendance.checkInTime),
                  style: TextStyle(
                      color: StyleColor.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat("MM").format(attendance.checkInTime),
                  style: TextStyle(color: StyleColor.primary, fontSize: 12),
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "Punch in",
                style: TextStyle(
                  color: StyleColor.black_2,
                ),
              ),
              Text(
                DateFormat("hh:mm a").format(attendance.checkInTime),
                style: TextStyle(
                  color: StyleColor.black_2,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Punch out",
                style: TextStyle(
                  color: StyleColor.black_2,
                ),
              ),
              Text(
                attendance.checkOutTime == null ? "---" : DateFormat("hh:mm a").format(attendance.checkOutTime!),
                style: TextStyle(
                  color: StyleColor.black_2,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

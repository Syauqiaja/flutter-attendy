import 'package:attendy_flutter/core/values/colors.dart';
import 'package:flutter/material.dart';

InputDecoration defaultInputDecoration(String title) => InputDecoration(
      isDense: true,
      filled: true,
      fillColor: StyleColor.white_2,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: StyleColor.primary.withOpacity(0),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: title,
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
    );
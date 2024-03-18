import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetUtils {
  static const darkBlue = Color.fromRGBO(3, 4, 94, 1);
  static const blueAcentColor = Color.fromRGBO(144, 224, 239, 1);
  static const arrowBackButton = Icon(Icons.arrow_back_ios_new);
  static GetSnackBar myCustomSnackBar(
          {required String messageText, required Color backgroundColor}) =>
      GetSnackBar(
        backgroundColor: backgroundColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 25,
        messageText: Text(
          messageText,
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 2),
      );
}

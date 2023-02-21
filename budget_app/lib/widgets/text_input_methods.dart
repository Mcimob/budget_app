import 'package:flutter/material.dart';

class TextInputMethods {
  static String? errorText(TextEditingController controller) {
    final text = controller.text;
    if (text.isEmpty) {
      return 'Title can\'t be empty';
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField {
  static TextFormField noneBorderNumField({
    required TextEditingController controller,
    Function(String)? onChange,
    TextStyle? style,
    TextAlign align = TextAlign.start,
    bool focus = false,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: style,
        textAlign: align,
        autofocus: focus,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: onChange,
      );

  static TextFormField borderNumField({
    required TextEditingController controller,
    Function(String)? onChange,
    TextStyle? style,
    String? hintText,
    String? suffixText,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: style,
        decoration: InputDecoration(
          hintText: hintText,
          suffixText: suffixText,
        ),
        onChanged: onChange,
      );

  static TextFormField borderTextField({
    required TextEditingController controller,
    Function(String)? onChange,
    TextStyle? style,
    String? hintText,
    String? suffixText,
  }) =>
      TextFormField(
        controller: controller,
        style: style,
        decoration: InputDecoration(
          hintText: hintText,
          suffixText: suffixText,
        ),
        onChanged: onChange,
      );
}

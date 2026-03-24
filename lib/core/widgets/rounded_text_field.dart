import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autofocus;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final String? errorText;
  final Color borderColor;
  final Color focusedColor;
  final Color errorColor;
  final BorderRadius borderRadius;

  const RoundedTextField({
    super.key,
    this.controller,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.contentPadding = const EdgeInsets.only(
      left: 24,
      top: 18,
      right: 24,
      bottom: 18,
    ),
    this.hintText,
    this.errorText,
    this.borderColor = Colors.transparent,
    this.focusedColor = Colors.black,
    this.errorColor = Colors.red,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFF9E9E9E),
          fontSize: 14.0,
          letterSpacing: -0.25,
          height: 1.4,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: contentPadding,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: focusedColor),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: borderColor),
        ),
        errorText: errorText,
        errorStyle: TextStyle(),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: errorColor),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: borderRadius,
        // ),
      ),
    );
  }
}

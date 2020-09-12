import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_firebase/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  const CustomTextField(
      {Key key,
      this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: inputBoxBackground, borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        obscureText: isPasswordField ?? false,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "",
            contentPadding: EdgeInsets.all(24.0)),
        style: regularHeading,
      ),
    );
  }
}

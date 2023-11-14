import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.maxLength,
      this.prefixText,
      this.keyboard,
      this.password,
      this.icon});

  final TextEditingController? controller;
  final String? hintText;
  final String? prefixText;
  final int? maxLength;
  final String? keyboard;
  final bool? password;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(hintText != null ? hintText! : ""),
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: Icon(icon)
      ),
      obscureText: password != null ? password! : false,
      keyboardType:
          keyboard == "phone" ? TextInputType.phone : TextInputType.text,
      maxLength: maxLength,
    );
  }
}

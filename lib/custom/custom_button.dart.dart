import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.icon, this.onPressed, this.buttonText});
  final IconData? icon;
  final void Function()? onPressed;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      onPressed: onPressed,
      label: Text(
        buttonText != null ? buttonText! : "",
      ),
    );
  }
}

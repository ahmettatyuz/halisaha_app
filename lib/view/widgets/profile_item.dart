// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  ProfileItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressedFunction,
    this.color="green",
  });
  final IconData icon;
  final String label;
  final void Function() onPressedFunction;
  final String color;
  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    backgroundColor = Theme.of(context).colorScheme.background;
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(label),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}

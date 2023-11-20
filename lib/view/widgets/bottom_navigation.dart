import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.aspect_ratio),label: "asd"),
      BottomNavigationBarItem(icon: Icon(Icons.aspect_ratio),label: "asdasd"),
    ],);
  }
}
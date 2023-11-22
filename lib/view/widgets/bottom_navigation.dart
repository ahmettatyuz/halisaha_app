import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (index == 0) {
          ref.read(screenProvider.notifier).setScreen("home");
        }
        if (index == 1) {
          ref.read(screenProvider.notifier).setScreen("halisahalar");
        }
        if (index == 3) {
          ref.read(screenProvider.notifier).setScreen("rezervasyonlar");
        }
      },
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Akış"),
        BottomNavigationBarItem(
          icon: Icon(Icons.stadium),
          label: "Halısaha Bul",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_handball),
          label: "Oyuncu Bul",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_soccer),
          label: "Rezervasyonlar",
        ),
      ],
    );
  }
}

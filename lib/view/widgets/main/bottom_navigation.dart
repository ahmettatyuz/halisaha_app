import 'package:dot_navigation_bar/dot_navigation_bar.dart';
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
    return DotNavigationBar(
      marginR: const EdgeInsets.symmetric(vertical: 4),
      paddingR: const EdgeInsets.all(2),
      backgroundColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
      selectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        if (index == 0) {
          ref.read(screenProvider.notifier).setScreen("halisahalar");
        } else if (index == 1) {
          ref.read(screenProvider.notifier).setScreen("oyuncular");
        } else if (index == 2) {
          ref.read(screenProvider.notifier).setScreen("takimlar");
        } else if (index == 3) {
          ref.read(screenProvider.notifier).setScreen("rezervasyonlar");
        }
      },
      currentIndex: _currentIndex,

      // type: BottomNavigationBarType.fixed,
      items: [
        DotNavigationBarItem(
          icon: const Icon(Icons.stadium),
          // label: "Halısaha Bul",
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.sports_handball),
          // label: "Oyuncu Bul",
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.security),
          // label: "Oyuncu Bul",
        ),
        DotNavigationBarItem(
          icon: const Icon(Icons.date_range),
          // label: "Rezervasyonlar",
        ),
      ],
    );
  }
}

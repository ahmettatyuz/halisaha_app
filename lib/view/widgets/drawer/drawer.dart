import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/view/widgets/drawer/draweritem.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Image.asset(
                  "assets/icons/loginIcon.png",
                  scale: 6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Halısaha +",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          DrawerItem(
            onClick: () {
              ref.read(screenProvider.notifier).setScreen("halisahalar");
            },
            text: "Halısaha Bul",
            iconData: Icons.stadium,
          ),
          DrawerItem(
            onClick: () {},
            text: "Oyuncu Bul",
            iconData: Icons.sports_handball,
          ),
          DrawerItem(
            onClick: () {
              ref.read(screenProvider.notifier).setScreen("rezervasyonlar");
            },
            text: "Rezervasyonlar",
            iconData: Icons.date_range,
          ),
          DrawerItem(
            text: "Takımlar",
            iconData: Icons.security,
            onClick: () {
              ref.read(screenProvider.notifier).setScreen("takimlar");
            },
          ),
        ],
      ),
    );
  }
}

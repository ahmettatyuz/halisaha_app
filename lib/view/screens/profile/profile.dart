// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/global/providers/session_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/models/user.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/screens/profile/change_password.dart';
import 'package:halisaha_app/view/screens/profile/edit_profile.dart';
import 'package:halisaha_app/view/screens/profile/sessions.dart';
import 'package:halisaha_app/view/widgets/profile/profile_item.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  User user = User();
  double height = 10;
  Owner owner = Owner();
  Player player = Player();
  final ownerService = OwnerService();
  @override
  Widget build(BuildContext context) {
    user = ref.watch(userProvider);
    print("user: ");
    print(user.firstname);
    print(user.role);
    if (user.role == "owner") {
      owner = ref.watch(ownerProvider);
    } else {
      player = ref.watch(playerProvider);
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 2,
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50)),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: user.role == "owner"
                      ? Icon(
                          Icons.stadium,
                          size: 50,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.sports_handball,
                          size: 50,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      user.role == "owner"
                          ? Column(
                              children: [
                                Text(
                                  owner.pitchName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                Text(
                                  owner.mail!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  player.firstName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                Text(
                                  player.phone!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
          ),
          ProfileItem(
            icon: Icons.edit,
            label: "Bilgileri Düzenle",
            onPressedFunction: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const EditProfile()));
            },
          ),
          SizedBox(
            height: height,
          ),
          ProfileItem(
            icon: Icons.password,
            label: "Parola Değiştir",
            onPressedFunction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const ChangePassword(),
                ),
              );
            },
          ),
          SizedBox(
            height: height,
          ),
          if (user.role == "owner")
            Column(
              children: [
                ProfileItem(
                  icon: Icons.sports_soccer,
                  label: "Seansları Düzenle",
                  onPressedFunction: () {
                    if (ref.watch(sessionsProvider).isNotEmpty &&
                        ref.watch(sessionsProvider)[0].id != owner.id) {
                      ref
                          .read(sessionsProvider.notifier)
                          .fetchSessions(owner.id!);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const SessionEdit(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: height,
                ),
              ],
            ),
          ProfileItem(
            color: "red",
            icon: Icons.logout,
            label: "Çıkış Yap",
            onPressedFunction: () async {
              await TokenManager.setToken("null");
              ref.read(screenProvider.notifier).setScreen("login");
            },
          ),
        ],
      ),
    );
  }
}

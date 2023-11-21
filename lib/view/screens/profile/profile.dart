import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/screens/profile/change_password.dart';
import 'package:halisaha_app/view/screens/profile/edit_profile.dart';
import 'package:halisaha_app/view/screens/profile/sessions.dart';
import 'package:halisaha_app/view/widgets/profile_item.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  String role = "owner";
  double height = 10;
  Owner owner = Owner(ownerFirstName: "");
  final ownerService = OwnerService();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user.role == "owner") {
      owner = ref.watch(ownerProvider);
    } else {}
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: role == "owner"
                ? Icon(
                    Icons.stadium,
                    size: 150,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.sports_handball,
                    size: 150,
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
          SizedBox(
            height: height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (role == "owner")
                Column(
                  children: [
                    Text(
                      owner.ownerFirstName!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      owner.pitchName!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
            ],
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
          if (role == "owner")
            Column(
              children: [
                ProfileItem(
                  icon: Icons.sports_soccer,
                  label: "Seansları Düzenle",
                  onPressedFunction: () {
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
              }),
        ],
      ),
    );
  }
}

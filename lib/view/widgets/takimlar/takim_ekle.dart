import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/team_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_text_field.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:toastification/toastification.dart';

class TakimEkle extends ConsumerWidget {
  const TakimEkle({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = TextEditingController();
    return AlertDialog(
      content: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: "Takım adı",
              icon: Icons.security,
              controller: nameController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onPressed: () async {
                  Team team = Team();
                  team.captainPlayer = ref.watch(playerProvider).id;
                  team.createDate = DateTime.now();
                  team.name = nameController.text;
                  team.id=0;
                  await TeamsService().createTeam(team);
                  ref.read(teamsProvider.notifier).fetchAllTeams();
                  Navigator.pop(context);
                  toast(context, "Takımlar", "Takım oluşturuldu", ToastificationType.success, 3, Icons.check);
                },
                icon: Icons.add_box_rounded,
                buttonText: "Oluştur",
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined),
                label: const Text("İptal"),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/player_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:toastification/toastification.dart';

class TakimaEkle extends ConsumerStatefulWidget {
  const TakimaEkle({super.key, required this.playerId,required this.teams});
  final int playerId;
  final List<Team> teams;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TakimaEkleState();
}

class _TakimaEkleState extends ConsumerState<TakimaEkle> {
  int? selectedTeam;
  @override
  Widget build(BuildContext context) {
  List<Team> teams = widget.teams;
    // buraya geldiğinde yeni eklenen takımlar gözükmüyor çünkü ref.read yapılması gerekiyor.
    if (teams.isNotEmpty && selectedTeam == null) {
      selectedTeam = teams[0].id;
    }
    print("**************");
    print(teams.length);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/shield.png",
              scale: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Takım Seç",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
              value: selectedTeam,
              items: teams.where((element) => element.captainPlayer == ref.watch(playerProvider).id).map(
                (e) {
                    return DropdownMenuItem(value: e.id,child: Text(e.name!),);
                },
              ).toList(),
              onChanged: (item) {
                setState(() {
                  print(item);
                  selectedTeam = item;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: "Ekle",
                  icon: Icons.add,
                  onPressed: () async {
                    try {
                      if (selectedTeam == null) {
                        throw ("Lütfen bir takım seçiniz !");
                      }
                      if (await PlayerService().joinTeam(
                          widget.playerId.toString(),
                          selectedTeam.toString())) {
                        toast(context, "Takım", "Oyuncu takıma eklendi.",
                            ToastificationType.success, 3, Icons.check);
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      toast(context, "Takım", e, ToastificationType.error, 3,
                          Icons.error);
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("İptal"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

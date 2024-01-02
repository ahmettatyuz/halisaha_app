import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/rezervasyon_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';

class TakimSec extends ConsumerStatefulWidget {
  const TakimSec({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TakimSecState();
}

class _TakimSecState extends ConsumerState<TakimSec> {
  TextEditingController searchTakim = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Takımını Seç !",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomSearchBar(
          hint: "Takım ara",
          controller: searchTakim,
          textChanged: (word) {
            setState(() {});
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
            future: TeamsService().getTeamsIncludePlayer(ref.watch(playerProvider).id!),
            builder: ((context, snapshot) {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                List<Team> teams = snapshot.data!;
                teams = teams
                    .where((element) => element.name!
                        .toLowerCase()
                        .contains(searchTakim.text.toLowerCase()))
                    .toList();
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref.read(evSahibiProvider.notifier).setTakim(teams[index]);
                      },
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => TakimDetay(team: teams[index]),
                          ),
                        );
                      },
                      child: TakimCard(
                        team: teams[index],
                      ),
                    );
                  },
                  itemCount: teams.length,
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/rezervasyon_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';

class RakipSec extends ConsumerStatefulWidget {
  const RakipSec({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RakipSecState();
}

class _RakipSecState extends ConsumerState<RakipSec> {
  TextEditingController searchTakim = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Rakibini Seç !",
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
            future: TeamsService().getAllTeams(),
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
                        ref.read(deplasmanProvider.notifier).setRakipTakim(teams[index]);
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

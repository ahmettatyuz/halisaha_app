import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';

class Takimlar extends ConsumerStatefulWidget {
  const Takimlar({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TakimlarState();
}

class _TakimlarState extends ConsumerState<Takimlar> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // if (searchText.text.isNotEmpty) {
    //   takimlar = takimlar
    //       .where(
    //         (element) => element.name!
    //             .toLowerCase()
    //             .contains(searchText.text.toLowerCase()),
    //       )
    //       .toList();
    // }
    return Scaffold(
      body: FutureBuilder(
        future:
            TeamsService().getTeamsIncludePlayer(ref.watch(playerProvider).id!),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            List<Team> takimlar = snapshot.data!;
            takimlar = takimlar
                .where(
                  (element) => element.name!
                      .toLowerCase()
                      .contains(searchText.text.toLowerCase()),
                )
                .toList();
            return Column(
              children: [
                CustomSearchBar(
                  hint: "Takım ara",
                  textChanged: (word) {
                    setState(() {});
                  },
                  controller: searchText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: takimlar.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (i) async {
                          await TeamsService().deleteTeam(takimlar[index].id!,
                              ref.watch(playerProvider).id!);
                        },
                        background: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.error,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    TakimDetay(team: takimlar[index]),
                              ),
                            );
                          },
                          child: TakimCard(
                            team: takimlar[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';
import 'package:halisaha_app/view/widgets/session/session_card.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';

class RezervasyonOlustur extends ConsumerStatefulWidget {
  const RezervasyonOlustur({super.key, required this.sessionId});
  final int sessionId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RezervasyonOlusturState();
}

class _RezervasyonOlusturState extends ConsumerState<RezervasyonOlustur> {
  final SessionService service = SessionService();
  TextEditingController searchTakim = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rezervasyon Oluştur",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: service.getSessionById(widget.sessionId),
          builder: (ctx, snapshot) {
            if (snapshot.data != null) {
              Session session = snapshot.data!;
              return Column(
                children: [
                  SessionCard(
                    time: session.sessionTime.toString(),
                    id: session.id!,
                    index: -1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      future: TeamsService().getAllTeams(),
                      builder: ((context, snapshot) {
                        if (snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          List<Team> teams = snapshot.data!;
                          teams = teams
                              .where((element) => element.name!
                                  .toLowerCase()
                                  .contains(searchTakim.text.toLowerCase()))
                              .toList();
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  print("takım seçildi");
                                },
                                onLongPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          TakimDetay(team: teams[index]),
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
                          return const CircularProgressIndicator();
                        }
                      }),
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

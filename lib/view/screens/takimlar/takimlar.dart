import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/team_provider.dart';
import 'package:halisaha_app/models/team.dart';
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
    fetchAndSetTeams();
  }

  Future<void> fetchAndSetTeams() async {
    await ref.read(teamsProvider.notifier).fetchAllTeams();
  }

  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Team> takimlar = ref.watch(teamsProvider);
    if (searchText.text.isNotEmpty) {
      takimlar = takimlar
          .where(
            (element) => element.name!
                .toLowerCase()
                .contains(searchText.text.toLowerCase()),
          )
          .toList();
    }

    return Scaffold(
      body: takimlar.isNotEmpty
          ? takimlar[0].name != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          return InkWell(
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
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )
          : const Center(
              child: Text("Hiç takımınız yok"),
            ),
    );
  }
}

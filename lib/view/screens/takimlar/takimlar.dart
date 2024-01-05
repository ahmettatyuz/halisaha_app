import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_ekle.dart';
import 'package:toastification/toastification.dart';

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
    return Scaffold(
      body: FutureBuilder(
        future:
            TeamsService().getTeamsIncludePlayer(ref.watch(playerProvider).id!),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Hiç takımınız yok !"),
            );
          }
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
                        confirmDismiss: (direction) async {
                          if (DismissDirection.endToStart == direction) {
                            bool delete = false;
                            await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      takimlar[index]
                                                  .captainPlayer
                                                  .toString() ==
                                              ref.watch(userProvider).id
                                          ? "Takımı silmek istediğinizden emin misiniz ?"
                                          : "Takımdan ayrılmak istediğinize emin misiniz ? ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("İptal"),
                                        ),
                                        CustomButton(
                                          buttonText: "Evet",
                                          icon: Icons.check,
                                          onPressed: () async {
                                            await TeamsService().deleteTeam(
                                                takimlar[index].id!,
                                                ref.watch(playerProvider).id!);
                                            delete = true;
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                            return delete;
                          }
                          if (DismissDirection.startToEnd == direction &&
                              takimlar[index].captainPlayer.toString() ==
                                  ref.watch(userProvider).id) {
                            print("duzenle");
                            return false;
                          } else {
                            toast(
                                context,
                                "Uyarı",
                                "Takımı sadece sahibi düzenleyebilir.",
                                ToastificationType.info,
                                3,
                                Icons.info);
                          }
                          return false;
                        },
                        background: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
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
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton.extended(
          label: const Text("Takım oluştur"),
          onPressed: () {
            showDialog(
              context: context,
              useSafeArea: true,
              builder: (ctx) {
                return const TakimEkle();
              },
            ).then((value) => setState(() {}));
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

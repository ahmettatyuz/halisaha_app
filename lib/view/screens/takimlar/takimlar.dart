import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/team_provider.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_ekle.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Team> takimlar = ref.watch(teamsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Takımlar",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: takimlar[0].name != null
          ? ListView.builder(
              itemCount: takimlar.length,
              itemBuilder: (context, index) {
                return TakimCard(
                  team: takimlar[index],
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Takım oluştur"),
        onPressed: () {
          showDialog(
            context: context,
            useSafeArea: true,
            builder: (ctx) {
              return const TakimEkle();
            },
          );
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}

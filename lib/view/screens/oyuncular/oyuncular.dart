import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/services/player_service.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/widgets/oyuncular/oyuncu_card.dart';

class Oyuncular extends ConsumerStatefulWidget {
  const Oyuncular({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OyuncularState();
}

class _OyuncularState extends ConsumerState<Oyuncular> {
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PlayerService().getAllPlayers(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomSearchBar(
                  hint: "Oyuncu Ara",
                  textChanged: (text) {
                    setState(() {
                      print(text);
                    });
                  },
                  controller: searchText,
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (snapshot.data![index].firstName!.toLowerCase()
                          .contains(searchText.text.toLowerCase())) {
                        return PlayerCard(player: snapshot.data![index]);
                      }
                      return null;
                    },
                    itemCount: snapshot.data!.length,
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

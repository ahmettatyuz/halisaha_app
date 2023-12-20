import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/services/player_service.dart';
import 'package:halisaha_app/view/widgets/oyuncular/oyuncu_card.dart';

class Oyuncular extends ConsumerStatefulWidget {
  const Oyuncular({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OyuncularState();
}

class _OyuncularState extends ConsumerState<Oyuncular> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PlayerService().getAllPlayers(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return PlayerCard(player: snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/widgets/oyuncular/oyuncu_badge.dart';
import 'package:halisaha_app/view/widgets/oyuncular/takima_ekle.dart';

class OyuncuDetay extends ConsumerStatefulWidget {
  const OyuncuDetay({super.key, required this.player});
  final Player player;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OyuncuDetayState();
}

class _OyuncuDetayState extends ConsumerState<OyuncuDetay> {
  @override
  Widget build(BuildContext context) {
    void takimaEkleModal(Player player) async {
      List<Team> teams = await TeamsService().getPlayersTeam(ref.watch(playerProvider).id!);
      print(player.id);
      showDialog(
        context: context,
        builder: (ctx) {
          return TakimaEkle(
            playerId: player.id!,
            teams: teams,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.player.firstName!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          takimaEkleModal(widget.player);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        label: const Row(
          children: [
            Icon(Icons.add),
            Text("Takıma Ekle"),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.none,
              child: Image.asset(
                "assets/icons/player.png",
                scale: 3,
              ),
            ),
            Text(
              widget.player.firstName!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.primary,
              ),
              unratedColor: Theme.of(context).colorScheme.primaryContainer,
              onRatingUpdate: (rating) {
                debugPrint(rating.toString());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const OyuncuBadge(
              icon: Icons.date_range,
              text1: "Yaş: ",
              text2: "21",
            ),
            const SizedBox(
              height: 10,
            ),
            OyuncuBadge(
              icon: Icons.sports_handball,
              text1: "Mevki: ",
              text2: widget.player.position!,
            ),
            const SizedBox(
              height: 10,
            ),
            OyuncuBadge(
              icon: Icons.location_on,
              text1: "Konum: ",
              text2: Owner.turkishCities[widget.player.city].toString(),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.player.teams!.isNotEmpty
                ? Text(
                    "Oyuncunun Bulunduğu Takımlar",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    child: OyuncuBadge(
                        icon: Icons.shield_outlined,
                        text1: widget.player.teams![index].name.toString(),
                        text2: ""),
                  );
                },
                itemCount: widget.player.teams!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

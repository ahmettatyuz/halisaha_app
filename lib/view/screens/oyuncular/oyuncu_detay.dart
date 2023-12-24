import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
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
    void takimaEkleModal(Player player) {
      showDialog(
        context: context,
        builder: (ctx) {
          return TakimaEkle(
            playerId: player.id!,
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
            ElevatedButton.icon(
              onPressed: () {
                takimaEkleModal(widget.player);
              },
              label: const Text("Takıma Ekle"),
              icon: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

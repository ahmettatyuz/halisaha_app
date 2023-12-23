import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/view/widgets/oyuncular/oyuncu_badge.dart';

class OyuncuDetay extends ConsumerWidget {
  const OyuncuDetay({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void takimaEkleModal(Player player) {
      showDialog(
          context: context,
          builder: (ctx) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Takım Seç",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    DropdownButton(items: [], onChanged: (item) {}),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          player.firstName!,
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
              player.firstName!,
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
              text2: player.position!,
            ),
            const SizedBox(
              height: 10,
            ),
            OyuncuBadge(
              icon: Icons.location_on,
              text1: "Konum: ",
              text2: Owner.turkishCities[player.city].toString(),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                takimaEkleModal(player);
              },
              label: const Text("Takıma Ekle"),
              icon: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/view/screens/oyuncular/oyuncu_Detay.dart';

class PlayerCard extends ConsumerStatefulWidget {
  const PlayerCard({super.key, required this.player});
  final Player player;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OyuncuCardState();
}

class _OyuncuCardState extends ConsumerState<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => OyuncuDetay(player: widget.player)));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/icons/player.png",
                  scale: 5,
                ),
                Column(
                  children: [
                    Text(
                      widget.player.firstName!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            Owner.turkishCities[widget.player.city].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Mevki: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                        ),
                        Text(widget.player.position!),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.call,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.player.phone!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

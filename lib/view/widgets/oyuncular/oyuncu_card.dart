import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';

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
      child: Column(children: [
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
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        Owner.turkishCities[widget.player.city].toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
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
              child: InkWell(
                onTap: () {},
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
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}

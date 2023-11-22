import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/owner.dart';

class OwnerCard extends ConsumerStatefulWidget {
  const OwnerCard({super.key, required this.owner});
  final Owner owner;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OwnerCardState();
}

class _OwnerCardState extends ConsumerState<OwnerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                print("tıklandı");
              },
              child: Column(
                children: [
                  Text(
                    widget.owner.pitchName!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/icons/pitch.png",
                        scale: 5,
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
                              widget.owner.address!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone,
                        size: 20, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.owner.phone!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.owner.point!.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.star,
                        size: 20, color: Theme.of(context).colorScheme.primary),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

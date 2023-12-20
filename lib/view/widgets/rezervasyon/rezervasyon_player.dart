import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';

class RezervasyonPlayer extends ConsumerWidget {
  const RezervasyonPlayer({
    super.key,
    required this.session,
  });
  final ReservedSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(children: [
        Text(
          session.session!.owner!.ownerFirstName!.toString(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/icons/reservation.png",
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
                    session.session!.owner!.address!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
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
                      session.session!.owner!.phone!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${session.date} ${session.session!.sessionTime!}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  )
                ],
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

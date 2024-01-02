import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';

class RezervasyonOwner extends ConsumerWidget {
  const RezervasyonOwner({super.key, required this.session});
  final ReservedSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(children: [
        Text(
          "Rezervasyon",
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
            Column(
              children: [
                Text(
                  "Takımlar",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(session.evSahibiTakim!.name!),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(session.deplasmanTakim!.name!),
                  ],
                ),
              ],
            )
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Seans Tarih ve Saati: ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            Text(
              "${session.date} ${session.session!.sessionTime}",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}

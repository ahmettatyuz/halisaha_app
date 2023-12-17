import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';
import 'package:halisaha_app/models/user.dart';
import 'package:halisaha_app/services/reserved_sessions_service.dart';
import 'package:halisaha_app/view/widgets/rezervasyon_owner.dart';
import 'package:halisaha_app/view/widgets/rezervasyon_player.dart';

class Rezervasyonlar extends ConsumerStatefulWidget {
  const Rezervasyonlar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RezervasyonlarState();
}

class _RezervasyonlarState extends ConsumerState<Rezervasyonlar> {
  ReserveSession reserveService = ReserveSession();

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider);
    return FutureBuilder(
      future: user.role=="player" ? reserveService.getReservedSessionForPlayer(user.id!) : reserveService.getReservedSessionForOwner(user.id!),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "Hiç rezerve edilmiş seans yok !",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          );
        } else if (snapshot.hasData) {
          List<ReservedSession> reservedSessions = snapshot.data!;

          return ListView.builder(
            itemCount: reservedSessions.length,
            itemBuilder: (context, index) {
              var session = reservedSessions[index];
              return user.role == "player" ? RezervasyonPlayer(session: session): RezervasyonOwner(session: session);
            },
          );
        } else {
          return Center(
            child: Text(
              "Hiç rezerve edilmiş seans yok !",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          );
        }
      },
    );
  }
}

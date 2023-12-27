// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/rezervasyon_provider.dart';
import 'package:halisaha_app/global/providers/session_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:halisaha_app/view/screens/rezervasyonlar/rezervasyon_olustur.dart';
import 'package:halisaha_app/view/widgets/session/add_session.dart';
import 'package:toastification/toastification.dart';

class SessionCard extends ConsumerStatefulWidget {
  const SessionCard(
      {super.key,
      required this.time,
      required this.id,
      required this.index,
      this.dismissible = true});
  final String time;
  final int id;
  final int index;
  final bool dismissible;
  @override
  ConsumerState<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends ConsumerState<SessionCard> {
  Card card() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.index >= 0
                    ? Text(
                        "${widget.index + 1}. Seans",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      )
                    : Container(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.time,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/icons/clock.png",
                  scale: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionService = SessionService();
    Future<void> removeSession(int id) async {
      // try {
      Session removedSession = await sessionService.removeSession(id);
      if (removedSession.id != null) {
        toast(context, "Seanslarım", "Seans kaldırıldı",
            ToastificationType.success, 2, Icons.check);
        ref
            .read(sessionsProvider.notifier)
            .fetchSessions(ref.watch(ownerProvider).id!);
      }
    }

    if (!widget.dismissible) {
      final user = ref.watch(userProvider);
      return InkWell(
        onTap: user.role == "player"
            ? () {
                // showDatePicker(
                //   context: context,
                //   initialDate: DateTime.now(),
                //   firstDate: DateTime.now(),
                //   lastDate: DateTime.now().add(
                //     const Duration(days: 30),
                //   ),
                // ).then((value) {
                //   if (value != null) {
                //     ReserveSessionService().reserveSession(
                //         value.toString().split(" ")[0],
                //         widget.id,
                //         ref.watch(userProvider).id!);
                //   }
                // });
                ref.read(evSahibiProvider.notifier).setTakim(null);
                ref.read(deplasmanProvider.notifier).setRakipTakim(null);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            RezervasyonOlustur(sessionId: widget.id)));
              }
            : null,
        child: card(),
      );
    } else {
      return Dismissible(
        background: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.error,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ],
          ),
        ),
        key: UniqueKey(),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            removeSession(widget.id);
            return true;
          } else {
            showModalBottomSheet<void>(
              useSafeArea: true,
              context: context,
              builder: (ctx) => AddSession(
                id: widget.id,
                time: widget.time,
              ),
            );
            return false;
          }
        },
        child: card(),
      );
    }
  }
}

// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/session_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:toastification/toastification.dart';

class AddSession extends ConsumerStatefulWidget {
  AddSession({super.key, this.id = 0, this.time = "__:__"});
  final int id;
  String time;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSessionState();
}

class _AddSessionState extends ConsumerState<AddSession> {
  SessionService sessionService = SessionService();
  Session session = Session();
  void addSession() async {
    if (widget.time == "__:__") {
      await messageBox(context, "Uyarı", "Lütfen bir saat seçin.", "Tamam");
    } else {
      try {
        print(widget.time);
        session = await sessionService.addSession(
            ref.watch(ownerProvider).id!, widget.time);
        Navigator.pop(context);
        ref
            .read(sessionsProvider.notifier)
            .fetchSessions(ref.read(ownerProvider).id!);
        print(ref.watch(sessionsProvider));
        toast(context, "Seanslarım", "Seans eklendi.",
            ToastificationType.success, 2, Icons.check);
      } catch (e) {
        await messageBox(context, "Uyarı", e.toString(), "Tamam");
      }
    }
  }

  void editSession() async {
    try {
      session = await sessionService.editSession(
          widget.id, ref.watch(ownerProvider).id!, widget.time);
      Navigator.pop(context);
      ref
          .read(sessionsProvider.notifier)
          .fetchSessions(ref.read(ownerProvider).id!);
      print(ref.watch(sessionsProvider));
      toast(context, "Seanslarım", "Seans saati değiştirildi.",
          ToastificationType.success, 2, Icons.check);
    } catch (e) {
      await messageBox(context, "Uyarı", e.toString(), "Tamam");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.id == 0 ? "Seans Ekle" : "Seansı Düzenle",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const Divider(),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Seans saati:",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.time,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
              TextButton.icon(
                label: const Text("Seç"),
                icon: const Icon(Icons.watch_later_outlined),
                onPressed: () async {
                  final _time = widget.time;

                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: widget.time == "__:__"
                        ? TimeOfDay.now()
                        : TimeOfDay(
                            hour: int.parse(_time.split(":")[0]),
                            minute: int.parse(_time.split(":")[1])),
                  );
                  setState(() {
                    if (selectedTime != null) {
                      widget.time =
                          "${selectedTime.hour}:${selectedTime.minute}";
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            onPressed: () {
              if (widget.id == 0) {
                addSession();
              } else {
                editSession();
              }
            },
            buttonText: "Kaydet",
            icon: Icons.save,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

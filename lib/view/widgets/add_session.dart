import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/session_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/helpers.dart';

class AddSession extends ConsumerStatefulWidget {
  const AddSession({super.key,required this.refresh});
  final void Function() refresh;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSessionState();
}

class _AddSessionState extends ConsumerState<AddSession> {
  String time = "__:__";
  SessionService sessionService = SessionService();
  Session session = Session();
  void addSession() async {
    if (time == "__:__") {
      await messageBox(context, "Uyarı", "Lütfen bir saat seçin.", "Tamam");
    } else {
      try {
        session =
            await sessionService.addSession(ref.watch(ownerProvider).id!, time);
        Navigator.pop(context);
        // ref.read(sessionsProvider.notifier).setState(true);
        widget.refresh();
      } catch (e) {
        await messageBox(context, "Uyarı", e.toString(), "Tamam");
      }
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
            "Seans Ekle",
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
                    time,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
              TextButton.icon(
                label: const Text("Seç"),
                icon: const Icon(Icons.watch_later_outlined),
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    if (selectedTime != null) {
                      time = "${selectedTime.hour}:${selectedTime.minute}";
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
            onPressed: addSession,
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

// ignore_for_file: use_build_context_synchronously

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/rezervasyon_provider.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/reserved_sessions_service.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:halisaha_app/view/screens/rezervasyonlar/rakip_sec.dart';
import 'package:halisaha_app/view/screens/rezervasyonlar/takim_sec.dart';
import 'package:halisaha_app/view/widgets/session/session_card.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';
import 'package:toastification/toastification.dart';

class RezervasyonOlustur extends ConsumerStatefulWidget {
  const RezervasyonOlustur({super.key, required this.sessionId});
  final int sessionId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RezervasyonOlusturState();
}

class _RezervasyonOlusturState extends ConsumerState<RezervasyonOlustur> {
  final SessionService service = SessionService();
  TextEditingController searchTakim = TextEditingController();
  TextEditingController trasportAdresController = TextEditingController();
  String secilenTarih = "__/__/____";
  String secilenTarihValue = "";
  @override
  Widget build(BuildContext context) {
    Team? evsahibi = ref.watch(evSahibiProvider);
    Team? deplasman = ref.watch(deplasmanProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rezervasyon Oluştur",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: service.getSessionById(widget.sessionId),
          builder: (ctx, snapshot) {
            if (snapshot.data != null) {
              Session session = snapshot.data!;
              return Column(
                children: [
                  SessionCard(
                    time: session.sessionTime.toString(),
                    id: session.id!,
                    index: -1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  evsahibi == null
                      ? const Expanded(child: TakimSec())
                      : Column(
                          children: [
                            Text(
                              "Ev Sahibi Takım",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TakimCard(team: evsahibi),
                          ],
                        ),
                  evsahibi != null && deplasman == null
                      ? const Expanded(child: RakipSec())
                      : deplasman != null
                          ? Column(
                              children: [
                                Text(
                                  "Deplasman Takım",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TakimCard(team: deplasman),
                              ],
                            )
                          : Container(),
                  evsahibi != null && deplasman != null
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tarih: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                                CustomButton(
                                  buttonText: secilenTarih,
                                  icon: Icons.date_range,
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 30),
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          secilenTarih =formatDate(value, [dd, ' ', MM, ' ', yyyy],locale:const TurkishDateLocale());
                                        });
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            TextField(
                              controller: trasportAdresController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Servisimiz sizi nereden alsın ? "),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("İptal Et"),
                                ),
                                CustomButton(
                                    buttonText: "Rezervasyon Oluştur",
                                    icon: Icons.check,
                                    onPressed: () async {
                                      await ReserveSessionService().reserveSession(secilenTarih, widget.sessionId, evsahibi.id!, deplasman.id!, trasportAdresController.text);
                                      toast(context, "Rezervasyon", "Seansını rezerve edildi.", ToastificationType.success, 3, Icons.date_range);
                                      Navigator.popUntil(context, (route) => route.isFirst);
                                      ref.read(screenProvider.notifier).setScreen("rezervasyonlar");
                                    }),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

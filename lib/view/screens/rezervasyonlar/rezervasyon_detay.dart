// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:halisaha_app/view/screens/takimlar/takim_detay.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_card.dart';
import 'package:toastification/toastification.dart';

class RezervasyonDetay extends ConsumerStatefulWidget {
  const RezervasyonDetay({super.key, required this.rezervasyon});
  final ReservedSession rezervasyon;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RezervasyonDetayState();
}

class _RezervasyonDetayState extends ConsumerState<RezervasyonDetay> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double coordinate1 = 0;
  double coordinate2 = 0;
  @override
  Widget build(BuildContext context) {
    if (ref.watch(userProvider).role == "owner") {
      coordinate1 = double.parse(ref.watch(ownerProvider).coordinate1!);
      coordinate2 = double.parse(ref.watch(ownerProvider).coordinate2!);
    } else {
      coordinate1 =
          double.parse(widget.rezervasyon.session!.owner!.coordinate1!);
      coordinate2 =
          double.parse(widget.rezervasyon.session!.owner!.coordinate2!);
    }

    final CameraPosition location = CameraPosition(
      target: LatLng(coordinate1, coordinate2),
      zoom: 16,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rezervasyon",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: MediaQuery.of(context).size.width - 20,
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: location,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("1"),
                    position: location.target,
                  ),
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.rezervasyon.session!.owner!.pitchName.toString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.date_range),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.rezervasyon.date} ${widget.rezervasyon.session!.sessionTime}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.watch_later_outlined),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      buttonText: widget.rezervasyon.session!.owner!.phone,
                      icon: Icons.call,
                      onPressed: () {
                        toast(
                          context,
                          "Uyarı",
                          "Bu numara aranamıyor.",
                          ToastificationType.error,
                          3,
                          Icons.call_end,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ev Sahibi Takım",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: TakimCard(team: widget.rezervasyon.evSahibiTakim!),
                      onTap: () async {
                        Team team = await TeamsService()
                            .getTeam(widget.rezervasyon.evSahibiTakimId!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => TakimDetay(team: team)),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Deplasman Takım",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child:
                          TakimCard(team: widget.rezervasyon.deplasmanTakim!),
                      onTap: () async {
                        Team team = await TeamsService()
                            .getTeam(widget.rezervasyon.deplasmanTakimId!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => TakimDetay(team: team)));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.rezervasyon.address!.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            "Servisin sizi alacağı konum",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          Text(widget.rezervasyon.address!),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

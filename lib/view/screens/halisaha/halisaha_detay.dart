import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/view/widgets/session_card.dart';
import 'package:url_launcher/url_launcher.dart';

class Halisaha extends ConsumerStatefulWidget {
  const Halisaha({super.key, required this.owner});
  final Owner owner;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HalisahaState();
}

class _HalisahaState extends ConsumerState<Halisaha> {
  final sessionService = SessionService();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final CameraPosition location = CameraPosition(
      target: LatLng(double.parse(widget.owner.coordinate1!), double.parse(widget.owner.coordinate2!)),
      zoom: 16,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.owner.pitchName!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width - 20,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: location,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {Marker(markerId:const MarkerId("1"),position: location.target)},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                label: const Text("Yol Tarifi Al"),
                icon: const Icon(Icons.route),
                onPressed: () {
                  launchUrl(Uri.parse("https://maps.apple.com/?q=${location.target.latitude},${location.target.longitude}"));
                },
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Seanslar",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          FutureBuilder(
            future: sessionService.getSessions(widget.owner.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Hata: ${snapshot.error}'),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Session> sessions = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return SessionCard(
                        time: sessions[index].sessionTime!,
                        id: sessions[index].id!,
                        index: index,
                        dismissible: false,
                      );
                    },
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text("Bu halısahanın hiç seansı yok! "),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

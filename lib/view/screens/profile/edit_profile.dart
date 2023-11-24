// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/services/player_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_text_field.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:toastification/toastification.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final ownerService = OwnerService();
  final playerService = PlayerService();
  Owner owner = Owner();
  Player player = Player();
  bool isOwner = true;
  double paddingValue = 20.0;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  double currentLatitude = 0;
  double currentLongitude = 0;
  Set<Marker> markers = {};

  TextEditingController adSoyadController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController epostaController = TextEditingController();
  TextEditingController isyeriController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  String selectedCity = "01";


  void updateOwnerProfile() async {
    try {
      final result = await ownerService.update(
        owner.id!,
        adSoyadController.text,
        telefonController.text,
        selectedCity,
        epostaController.text,
        isyeriController.text,
        adresController.text,
        websiteController.text,
        owner.point!,
        currentLatitude.toString(),
        currentLongitude.toString(),
      );
      ref.read(ownerProvider.notifier).ownerState(result);
      toast(context, "PROFİL", "Profiliniz güncellendi",
          ToastificationType.success, 2, Icons.check);
      // await messageBox(context, "Uyarı", "Bilgileriniz güncellendi.", "Tamam");
      Navigator.pop(context);
    } catch (e) {
      toast(context, "PROFİL", "İşlem başarısız", ToastificationType.error, 2,
          Icons.error);
    }
  }

  void updatePlayerProfile() async {
    try {
      final result = await playerService.update(
        player.id!,
        adSoyadController.text,
        telefonController.text,
        selectedCity,
        adresController.text,
        epostaController.text,
      );
      ref.read(playerProvider.notifier).playerState(result);
      toast(context, "PROFİL", "Profiliniz güncellendi",
          ToastificationType.success, 2, Icons.check);
      Navigator.pop(context);
    } catch (e) {
      toast(context, "PROFİL", "İşlem başarısız", ToastificationType.error, 2,
          Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    isOwner = ref.watch(roleProvider);
    if (isOwner) {
      owner = ref.watch(ownerProvider);
      adSoyadController.text = owner.ownerFirstName!;
      telefonController.text = owner.phone!;
      selectedCity = owner.city!;
      epostaController.text = owner.mail!;
      isyeriController.text = owner.pitchName!;
      adresController.text = owner.address!;
      websiteController.text = owner.web!;
      if (markers.isEmpty) {
        currentLatitude = double.parse(owner.coordinate1!);
        currentLongitude = double.parse(owner.coordinate2!);
      }
      markers = {
        Marker(
          markerId: const MarkerId("1"),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: "Halısahanızın Konumu"),
          position: LatLng(currentLatitude, currentLongitude),
        ),
      };
    } else {
      player = ref.watch(playerProvider);
      adSoyadController.text = player.firstName!;
      telefonController.text = player.phone!;
      selectedCity = player.city!;
      epostaController.text = player.mail!;
      adresController.text = player.address!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bilgileri Düzenle",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: CustomTextField(
                hintText: "Ad Soyad",
                controller: adSoyadController,
                icon: Icons.person,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: CustomTextField(
                hintText: "Telefon",
                prefixText: "+90 ",
                maxLength: 10,
                keyboard: "phone",
                controller: telefonController,
                icon: Icons.phone,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: paddingValue - 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Şehir:",
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                    DropdownButton(
                      hint: const Text("Şehir"),
                      items: Owner.turkishCities.keys
                          .toList()
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(Owner.turkishCities[e].toString()),
                              ))
                          .toList(),
                      value: selectedCity,
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value!;
                        });
                      },
                    ),
                    const Icon(Icons.location_city)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (!isOwner)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingValue),
                    child: CustomTextField(
                      hintText: "Adres",
                      controller: adresController,
                      icon: Icons.location_on,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: CustomTextField(
                hintText: "E-Posta Adresi",
                controller: epostaController,
                icon: Icons.mail,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (isOwner)
              Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: MediaQuery.of(context).size.width - 40,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GoogleMap(
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        )
                      },
                      markers: markers,
                      onTap: (LatLng coordianates) {
                        setState(
                          () {
                            currentLatitude = coordianates.latitude;
                            currentLongitude = coordianates.longitude;
                          },
                        );
                      },
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        zoom: 15,
                        target: LatLng(currentLatitude, currentLongitude),
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      scrollGesturesEnabled: true,
                    ),
                  ),
                  Text(
                    "Halısaha Bilgileri",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingValue),
                    child: CustomTextField(
                      hintText: "Halısaha Adı",
                      controller: isyeriController,
                      icon: Icons.sports_soccer,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingValue),
                    child: CustomTextField(
                      hintText: "Halısaha Adresi",
                      controller: adresController,
                      icon: Icons.location_on,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingValue),
                    child: CustomTextField(
                      hintText: "Web Adresi (Opsiyonel)",
                      controller: websiteController,
                      icon: Icons.web,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            CustomButton(
              icon: Icons.save,
              buttonText: "Kaydet",
              onPressed: () {
                if (isOwner) {
                  updateOwnerProfile();
                } else {
                  updatePlayerProfile();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

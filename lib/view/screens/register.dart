import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/user.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/custom/custom_text_field.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/services/user_service.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  double paddingValue = 20.0;
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController epostaController = TextEditingController();
  TextEditingController isyeriController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  String selectedCity = "01";
  TextEditingController parola1Controller = TextEditingController();
  TextEditingController parola2Controller = TextEditingController();
  User user = User();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  double currentLatitude = 0;
  double currentLongitude = 0;
  Set<Marker> markers = {};

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _registerOwner() async {
    String message = "";
    String adSoyad = adSoyadController.text;
    String telefon = telefonController.text;
    String eposta = epostaController.text;
    String isyeri = isyeriController.text;
    String adres = adresController.text;
    String parola1 = parola1Controller.text;
    String parola2 = parola2Controller.text;
    String webAdres = websiteController.text;
    if (adSoyad.isNotEmpty &&
        telefon.isNotEmpty &&
        double.tryParse(telefon) != null &&
        eposta.isNotEmpty &&
        parola1.isNotEmpty &&
        isyeri.isNotEmpty &&
        adres.isNotEmpty) {
      if (parola1 == parola2) {
        if (markers.isNotEmpty) {
          OwnerService()
              .register(
                  parola1,
                  adSoyad,
                  eposta,
                  telefon,
                  selectedCity,
                  adres,
                  isyeri,
                  webAdres,
                  markers.first.position.latitude.toString(),
                  markers.first.position.longitude.toString())
              .then((value) {
            if (value[0] == "200") {
              Navigator.pop(context);
            } else {
              messageBox(context, "Uyarı", value[1], "Tamam");
            }
          });
        } else {
          message = "Lütfen haritadan halısahanızın konumunu seçin.";
        }
      } else {
        message = "Parolalar uyuşmuyor.";
      }
    } else {
      message = "Lütfen tüm alanlara geçerli değerler girin";
    }
    if (message != "") {
      messageBox(context, "Uyarı", message, "Tamam");
    }
  }

  void _registerPlayer() async {
    String message = "";
    String adSoyad = adSoyadController.text;
    String telefon = telefonController.text;
    String eposta = epostaController.text;
    String adres = adresController.text;
    String parola1 = parola1Controller.text;
    String parola2 = parola2Controller.text;
    if (adSoyad.isNotEmpty &&
        telefon.isNotEmpty &&
        double.tryParse(telefon) != null &&
        eposta.isNotEmpty &&
        parola1.isNotEmpty) {
      if (parola1 == parola2) {
        UserService()
            .registerPlayerRequest(
                parola1, adSoyad, eposta, telefon, selectedCity, adres, "")
            .then((value) {
          if (value[0] == "200") {
            Navigator.pop(context);
          } else {
            messageBox(context, "Uyarı", value[1], "Tamam");
          }
        });
      } else {
        message = "Parolalar uyuşmuyor";
      }
    } else {
      message = "Lütfen tüm alanlara geçerli değerleri girin";
    }
    if (message != "") {
      messageBox(context, "Uyaro", message, "Tamam");
    }
  }

  Future<void> _goToLocation(LatLng positon) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: positon, zoom: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = ref.read(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kullanıcı Hesabı Oluşturun ",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: user.role == "owner"
                  ? Icon(
                      Icons.stadium,
                      size: 150,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(
                      Icons.sports_handball,
                      size: 150,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            SwitchListTile(
              title: const Text("Halısaha sahibi misiniz ? "),
              value: user.role == "owner",
              onChanged: (checked) {
                setState(() {});
                ref
                    .read(userProvider.notifier)
                    .userState(User(role: checked ? "owner" : "player"));
              },
            ),
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
                        setState(
                          () {
                            selectedCity = value!;
                          },
                        );
                      },
                    ),
                    const Icon(Icons.location_city),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (user.role == "player")
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: CustomTextField(
                hintText: "Parola",
                password: true,
                controller: parola1Controller,
                icon: Icons.password,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: CustomTextField(
                hintText: "Parola (Tekrar)",
                password: true,
                controller: parola2Controller,
                icon: Icons.password,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (user.role == "owner")
              Column(
                children: [
                  Text(
                    "Halısaha Bilgileri",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                  ),
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
                            markers = {
                              Marker(
                                markerId: const MarkerId("1"),
                                position: coordianates,
                                icon: BitmapDescriptor.defaultMarker,
                                infoWindow: const InfoWindow(
                                    title: "Halısahanızın Konumu"),
                              ),
                            };
                          },
                        );
                      },
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLatitude, currentLongitude),
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        try {
                          _mapController.complete(controller);
                        } catch (e) {}
                      },
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      scrollGesturesEnabled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _determinePosition().then(
                            (value) {
                              _goToLocation(
                                LatLng(value.latitude, value.longitude),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.location_searching_outlined),
                        label: const Text("Konumu Bul"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                      hintText: "Halısaha Adres Tarifi",
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
            ElevatedButton.icon(
              onPressed: () {
                if (user.role == "owner") {
                  _registerOwner();
                } else {
                  _registerPlayer();
                }
              },
              icon: const Icon(Icons.account_box),
              label: const Text("Kayıt Ol"),
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

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_text_field.dart';
import 'package:halisaha_app/view/custom/helpers.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
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
      );
      ref.read(ownerProvider.notifier).ownerState(result);
      await messageBox(context, "Uyarı", "Bilgileriniz güncellendi.", "Tamam");
      Navigator.pop(context);
    } catch (e) {
      messageBox(context, "Uyarı", e.toString(), "Tamam");
    }
  }

  final ownerService = OwnerService();
  Owner owner = Owner();
  bool isOwner = true;
  double paddingValue = 20.0;
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController epostaController = TextEditingController();
  TextEditingController isyeriController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  String selectedCity = "01";
  @override
  Widget build(BuildContext context) {
    isOwner = ref.watch(userProvider).role == "owner";
    if (isOwner) {
      owner = ref.watch(ownerProvider);
      adSoyadController.text = owner.ownerFirstName!;
      telefonController.text = owner.phone!;
      selectedCity = owner.city!;
      epostaController.text = owner.mail!;
      isyeriController.text = owner.pitchName!;
      adresController.text = owner.address!;
      websiteController.text = owner.web!;
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
                onPressed: updateOwnerProfile),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:halisaha_app/custom/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isOwner = false;
  double paddingValue = 12.0;
  @override
  Widget build(BuildContext context) {
    // return const Text("data");
    // return const GoogleMap(
    //   initialCameraPosition: CameraPosition(
    //     target: LatLng(10, 10),
    //   ),
    // );
  return
    Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Kullanıcı Hesabı Oluşturun ",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            SwitchListTile(
              title: const Text("Halısaha sahibi misiniz ? "),
              value: isOwner,
              onChanged: (checked) {
                setState(() {
                  isOwner = checked;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(hintText: "Ad Soyad"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(
                hintText: "Telefon",
                prefixText: "+90 5",
                maxLength: 9,
                keyboard: "phone",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(
                hintText: "E-Posta Adresi",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(
                hintText: "Parola",
                password: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(
                hintText: "Parola (Tekrar)",
                password: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(
                hintText: "Parola (Tekrar)",
                password: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(paddingValue),
              child: const CustomTextField(
                hintText: "Parola (Tekrar)",
                password: true,
              ),
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

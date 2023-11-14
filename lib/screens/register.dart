import 'package:flutter/material.dart';
import 'package:halisaha_app/custom/custom_text_field.dart';
import 'package:halisaha_app/custom/helpers.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/services/user_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isOwner = false;
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
        parola1.isNotEmpty) {
      if (parola1 == parola2) {
        UserService()
            .registerOwnerRequest(
                parola1, adSoyad, eposta, telefon, selectedCity, adres,isyeri,webAdres)
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
      messageBox(context, "Uyarı", message, "Tamam");
    }
  }

  void _registerPlayer() async {
    String message = "";
    String adSoyad = adSoyadController.text;
    String telefon = telefonController.text;
    String eposta = epostaController.text;
    String isyeri = isyeriController.text;
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

  @override
  Widget build(BuildContext context) {
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
              child: isOwner
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
            ElevatedButton.icon(
              onPressed: (){
                if(isOwner){
                  _registerOwner();
                }else{
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

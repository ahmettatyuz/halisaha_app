// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_text_field.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:toastification/toastification.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  void changePassword() async {
    try {
      String pw1 = parola1Controller.text;
      String pw2 = parola2Controller.text;
      if (pw1 == pw2 && pw1.isNotEmpty) {
        await ownerService.changePassword(ref.watch(ownerProvider).id!,
            parola0Controller.text, parola1Controller.text);
        toast(context, "PROFİL", "Parolanız değiştirildi.",
          ToastificationType.success, 2, Icons.check);
        Navigator.pop(context);
      } else {
        toast(context, "PROFİL", "Parolalar uyuşmuyor.",
          ToastificationType.error, 2, Icons.error);
      }
    } catch (e) {
      await messageBox(context, "Uyarı", e.toString(), "Tamam");
    }
  }

  Owner owner = Owner();
  OwnerService ownerService = OwnerService();
  bool isOwner = false;
  double paddingValue = 20.0;
  TextEditingController parola0Controller = TextEditingController();
  TextEditingController parola1Controller = TextEditingController();
  TextEditingController parola2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Parolayı Değiştir",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingValue),
            child: CustomTextField(
              hintText: "Mevcut Parola",
              password: true,
              controller: parola0Controller,
              icon: Icons.password,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingValue),
            child: CustomTextField(
              hintText: "Yeni Parola",
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
              hintText: "Yeni Parola (Tekrar)",
              password: true,
              controller: parola2Controller,
              icon: Icons.password,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              icon: Icons.save,
              buttonText: "Kaydet",
              onPressed: changePassword),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/user.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_text_field.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/services/auth_service.dart';
import 'package:halisaha_app/view/custom/helpers.dart';
import 'package:halisaha_app/view/screens/register.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool isLoggingIn = false;
  bool isOwner = false;
  final ownerService = OwnerService();
  void _register() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return const Register();
    }));
  }

  void loginOwner() async {
    String phone = "5${telefonController.text}";
    String password = parolaController.text;
    isLoggingIn = true;
    try {
      String token = await AuthService().loginOwnerRequest(phone, password);
      if (TokenManager.verifyToken(token)) {
        TokenManager.token = token;
        final user = User.fromJson(JWT.decode(token).payload);
        ref.read(userProvider.notifier).userState(user);
        if (user.role == "owner") {
          final owner = await ownerService.getOwnerById(user.id!);
          ref.read(ownerProvider.notifier).ownerState(owner);
          print("login ekranından manuel giriş");
          print("telefon :" + owner.phone.toString());
        }
        
        await TokenManager.setToken(token);
        ref.read(screenProvider.notifier).setScreen("home");
      } else {
        ref.read(screenProvider.notifier).setScreen("login");
        messageBox(context, "Uyarı", token.toString(), "Tamam");
      }
    } catch (e) {
      ref.read(screenProvider.notifier).setScreen("login");
      messageBox(context, "Uyarı", e.toString(), "Tamam");
    }

    setState(() {
          isLoggingIn=false;
        });
  }

  // void loginPlayer() {
  //   String phone = "5${telefonController.text}";
  //   String password = parolaController.text;
  //   ref.read(screenProvider.notifier).auth(1);
  //   AuthService().loginPlayerRequest(phone, password).then(
  //     (value) {
  //       if (value.startsWith("ey")) {
  //         TokenManager.setToken(value).then((_) {
  //           ref.read(authProvider.notifier).auth(2);
  //         });
  //       } else {
  //         ref.read(authProvider.notifier).auth(0);
  //         messageBox(context, "Uyarı", value.toString(), "Tamam");
  //       }
  //     },
  //   ).catchError((e) {
  //     ref.read(authProvider.notifier).auth(0);
  //     messageBox(context, "Uyarı", e.toString(), "Tamam");
  //   });
  // }

  TextEditingController telefonController = TextEditingController();
  TextEditingController parolaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isOwner = ref.watch(roleProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/loginIcon.png",
              scale: 2.5,
            ),
            const SizedBox(
              height: 15,
            ),
            !isLoggingIn
                ? Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            keyboard: "phone",
                            hintText: "Telefon",
                            prefixText: "+90 5",
                            controller: telefonController,
                            maxLength: 9,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hintText: "Parola",
                            controller: parolaController,
                            password: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SwitchListTile(
                        title: const Text("Halısaha Hesabı"),
                        value: isOwner,
                        onChanged: (checked) {
                          ref.read(roleProvider.notifier).changeRole(checked);
                          // ref.read(roleProvider.notifier) = checked;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: _register,
                            child: const Text("Hesabınız yok mu ?"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            icon: Icons.sports_volleyball,
                            buttonText: "Giriş Yap",
                            onPressed: () {
                              if (isOwner) {
                                loginOwner();
                              } else {
                                // loginPlayer();
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/custom/custom_button.dart.dart';
import 'package:halisaha_app/custom/custom_text_field.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/providers/auth_provider.dart';
import 'package:halisaha_app/services/auth_service.dart';
import 'package:halisaha_app/screens/register.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  int isLoggedIn = 0;
  bool isOwner = false;
  void _register() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return const Register();
    }));
  }

  void loginOwner() {
    String phone = "5${telefonController.text}";
    String password = parolaController.text;
    ref.read(authProvider.notifier).auth(1);
    AuthService().loginOwnerRequest(phone, password).then(
      (value) {
        if (value.startsWith("ey")) {
          TokenManager.setToken(value).then((_) {
            ref.read(authProvider.notifier).auth(2);
          });
        } else {
          ref.read(authProvider.notifier).auth(0);
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Uyarı"),
                content: Text(value.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Tamam"),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  void loginPlayer() {
    String phone = "5${telefonController.text}";
    String password = parolaController.text;
    ref.read(authProvider.notifier).auth(1);
    AuthService().loginPlayerRequest(phone, password).then(
      (value) {
        if (value.startsWith("ey")) {
          TokenManager.setToken(value).then((_) {
            ref.read(authProvider.notifier).auth(2);
          });
        } else {
          ref.read(authProvider.notifier).auth(0);
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Uyarı"),
                content: Text(value.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Tamam"),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  TextEditingController telefonController = TextEditingController();
  TextEditingController parolaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isLoggedIn = ref.watch(authProvider);
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
            isLoggedIn == 0
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
                          setState(() {
                            isOwner = checked;
                          });
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
                            onPressed: (){
                              if(isOwner){
                                loginOwner();
                              }else{
                                loginPlayer();
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

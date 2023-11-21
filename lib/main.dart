// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/models/user.dart';
import 'package:halisaha_app/services/owner_service.dart';
import 'package:halisaha_app/view/screens/halisahalar.dart';
import 'package:halisaha_app/view/screens/login.dart';
import 'package:halisaha_app/view/screens/home.dart';
import 'package:halisaha_app/view/screens/profile/edit-profile.dart';
import 'package:halisaha_app/view/screens/profile/profile.dart';
import 'package:halisaha_app/view/screens/rezervasyonlar.dart';
import 'package:halisaha_app/view/widgets/bottom_navigation.dart';
import 'package:halisaha_app/view/widgets/modal_bottom.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 1, 147, 50),
  ),
);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: MyApp()));
}

AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Halısaha App",
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const Main(),
    );
  }
}

class Main extends ConsumerStatefulWidget {
  const Main({super.key});

  @override
  ConsumerState<Main> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  final ownerService = OwnerService();
  Widget activeScreen = const Login();
  String screen = "";

  void showModalBottom() {
    showModalBottomSheet<void>(
        // isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) {
          return const ModalBottom();
        });
  }

  void loginCheck() async {
    // token varsa ve geçerliyse loginState'yi günceller
    String? token = await TokenManager.getToken();
    if (token != null && TokenManager.verifyToken(token)) {
      screen = "home";
      TokenManager.token = token;
      final user = User.fromJson(JWT.decode(token).payload);
      ref.read(userProvider.notifier).userState(user);
      if (user.role == "owner") {
        final owner = await ownerService.getOwnerById(user.id!);
        ref.read(ownerProvider.notifier).ownerState(owner);
        print("önceki oturumdan otomatik giriş");
        print("telefon :" + owner.phone.toString());
      }
    } else {
      screen = "login";
    }
    ref.read(screenProvider.notifier).setScreen(screen);
  }

  void router(screen) {
    if (screen == "login") {
      activeScreen = const Login();
    } else if (screen == "home") {
      activeScreen = const Home();
    } else if (screen == "profil") {
      activeScreen = const Profile();
    } else if (screen == "halisahalar") {
      activeScreen = const Halisahalar();
    } else if (screen == "rezervasyonlar") {
      activeScreen = const Rezervasyonlar();
    } else if (screen == "bilgileriDuzenle") {
      activeScreen = const EditProfile();
    }
  }

  @override
  void initState() {
    super.initState();

    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    screen = ref.watch(screenProvider);
    router(screen);
    TokenManager.getToken().then((value) {
      print("token: $value");
    });
    return Scaffold(
      floatingActionButton: screen == "rezervasyonlar"
          ? IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
              iconSize: 35,
            )
          : null,
      appBar: AppBar(
        title: const Text(
          "HALISAHA KRALI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
        actions: [
          screen != "login"
              ? IconButton(
                  onPressed: () {
                    showModalBottom();
                  },
                  icon: const Icon(Icons.person),
                )
              : const Text(""),
        ],
      ),
      body: activeScreen,
      bottomNavigationBar: screen != "login" ? const BottomNavigation() : null,
    );
  }
}

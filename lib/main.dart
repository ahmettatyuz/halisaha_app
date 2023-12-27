// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings
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
import 'package:halisaha_app/services/player_service.dart';
import 'package:halisaha_app/view/screens/halisaha/halisahalar.dart';
import 'package:halisaha_app/view/screens/login.dart';
import 'package:halisaha_app/view/screens/oyuncular/oyuncular.dart';
import 'package:halisaha_app/view/screens/profile/profile.dart';
import 'package:halisaha_app/view/screens/takimlar/takimlar.dart';
import 'package:halisaha_app/view/widgets/main/bottom_navigation.dart';
import 'package:halisaha_app/view/widgets/main/modal_bottom.dart';
import 'package:halisaha_app/view/widgets/takimlar/takim_ekle.dart';

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
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
      title: "Halısaha+",
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
  final playerService = PlayerService();
  Widget activeScreen = const Login();
  String screen = "";
  bool isOwner = false;

  void showModalBottom() {
    showModalBottomSheet<void>(
      useSafeArea: true,
      context: context,
      builder: (ctx) {
        return const ModalBottom();
      },
    );
  }

  void loginCheck() async {
    // token varsa ve geçerliyse loginState'yi günceller
    String? token = await TokenManager.getToken();
    if (token != null && TokenManager.verifyToken(token)) {
      screen = "halisahalar";
      TokenManager.token = token;
      final user = User.fromJson(JWT.decode(token).payload);
      if (user.role == "owner") {
        try {
          final owner = await ownerService.getOwnerById(user.id!);
          ref.read(userProvider.notifier).userState(user);
          ref.read(ownerProvider.notifier).ownerState(owner);
          print("önceki oturumdan otomatik giriş");
          print("telefon :" + owner.phone.toString());
        } catch (e) {
          screen = "login";
        }
      } else {
        try {
          final player = await playerService.getPlayerById(user.id!);
          ref.read(userProvider.notifier).userState(user);
          ref.read(playerProvider.notifier).playerState(player);
          print("önceki oturumdan otomatik giriş");
          print("telefon :" + player.phone.toString());
        } catch (e) {
          screen = "login";
        }
      }
    } else {
      screen = "login";
    }

    ref.read(screenProvider.notifier).setScreen(screen);
  }

  void router(screen) {
    if (screen == "login") {
      activeScreen = const Login();
    } else if (screen == "takimlar") {
      activeScreen = const Takimlar();
    } else if (screen == "profile") {
      activeScreen = const Profile();
    } else if (screen == "halisahalar") {
      activeScreen = const Halisahalar();
    } else if (screen == "rezervasyonlar") {
      // activeScreen = const Rezervasyonlar();
    } else if (screen == "oyuncular") {
      activeScreen = const Oyuncular();
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
      // drawer: screen!="login" ? const MyDrawer():null,
      appBar: AppBar(
        title: const Text(
          "HALISAHA+",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
        actions: screen != "login"
            ? [
                IconButton(
                  onPressed: () {
                    showModalBottom();
                  },
                  icon: const Icon(Icons.person),
                ),
              ]
            : [],
      ),
      floatingActionButton: screen == "takimlar"
          ? FloatingActionButton.extended(
              label: const Text("Takım oluştur"),
              onPressed: () {
                showDialog(
                  context: context,
                  useSafeArea: true,
                  builder: (ctx) {
                    return const TakimEkle();
                  },
                );
              },
              icon: const Icon(Icons.add),
            )
          : null,
      body: activeScreen,
      extendBody: true,
      bottomNavigationBar: screen != "login" ? const BottomNavigation() : null,
    );
  }
}

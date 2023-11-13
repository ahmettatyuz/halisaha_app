import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/providers/auth_provider.dart';
import 'package:halisaha_app/screens/login.dart';
import 'package:halisaha_app/screens/tabs.dart';
import 'package:halisaha_app/services/auth_service.dart';

void main() => runApp(const ProviderScope(child: MyApp()));
AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  int isLoggedIn = 0;

  @override
  void initState() {
    TokenManager.getToken().then((value) {
      if (value.toString() != "null") {
        isLoggedIn = 2;
      } else {
        isLoggedIn = 0;
      }
      ref.read(authProvider.notifier).auth(isLoggedIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn = ref.watch(authProvider);
    TokenManager.getToken().then((value){
      print(value);
    });
    return MaterialApp(
      title: "Halısaha App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
        ),
      ),
      home: Scaffold(
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
            isLoggedIn == 2
                ? IconButton(
                    onPressed: () {
                      AuthService.logout().then(
                        (value) {
                          ref.read(authProvider.notifier).auth(0);
                        },
                      );
                    },
                    icon: const Icon(Icons.logout),
                  )
                : const Text(""),
          ],
        ),
        body: isLoggedIn == 2 ? const Tabs() : const Login(),
      ),
    );
  }
}

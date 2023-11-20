import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/screen_provider.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:halisaha_app/services/auth_service.dart';

class ModalBottom extends ConsumerStatefulWidget {
  const ModalBottom({super.key});

  @override
  ConsumerState<ModalBottom> createState() => _ModalBottomState();
}

class _ModalBottomState extends ConsumerState<ModalBottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () {
              ref.read(screenProvider.notifier).setScreen("profil");
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.person),
            label: const Row(
              children: [
                Text("Profilim"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: () async {
              await TokenManager.setToken("null");
              ref.read(screenProvider.notifier).setScreen("login");
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.logout),
            label: const Row(
              children: [
                Text("Çıkış"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

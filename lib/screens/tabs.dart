import 'package:flutter/material.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});
  @override
  State<Tabs> createState() => _TabsState();
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

class _TabsState extends State<Tabs> {
  String token = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(token),
          ElevatedButton(
            onPressed: () {
              TokenManager.getToken().then((value) {
                setState(() {
                  token = value.toString();
                });
              });
            },
            child: const Text("tıkla"),
          ),
        ],
      ),
    );
  }
}

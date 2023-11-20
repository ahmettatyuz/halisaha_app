import 'package:flutter/material.dart';
import 'package:halisaha_app/models/token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

class _HomeState extends State<Home> {

  String token = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Hoşgeldin",
            style: TextStyle(fontSize: 25),
          ),
          Text(token),
          ElevatedButton(
            onPressed: () async {
              String? value = await TokenManager.getToken();
              setState(() {
                token = value.toString();
              });
            },
            child: const Text("tıkla"),
          ),
        ],
      ),
    );
  }
}

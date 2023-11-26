import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenNotifier extends StateNotifier<String> {
  ScreenNotifier(): super("login");
  String setScreen(String activeScreen){
    state = activeScreen;
    return activeScreen;
  }
}

final screenProvider = StateNotifierProvider<ScreenNotifier,String>((ref) {
  return ScreenNotifier();
});
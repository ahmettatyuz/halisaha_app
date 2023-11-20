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



class RoleNotifier extends StateNotifier<bool> {
  RoleNotifier(): super(false);
  bool changeRole(bool role){
    state = role;
    return role;
  }
}
final roleProvider = StateNotifierProvider<RoleNotifier,bool>((ref) {
  return RoleNotifier();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<int> {
  AuthNotifier(): super(0);
  int auth(int status){
    state = status;
    return status;
  }
}
final authProvider = StateNotifierProvider<AuthNotifier,int>((ref) {
  return AuthNotifier();
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
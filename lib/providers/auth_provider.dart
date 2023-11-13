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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';

class SessionsNotifier extends StateNotifier<bool> {
  SessionsNotifier() : super(true);
  void setState(bool newState){
    state = newState;
  }
}

final sessionsProvider = StateNotifierProvider<SessionsNotifier, bool>((ref) {
  return SessionsNotifier();
});


final sessionProvider = FutureProvider<List<Session>>((ref) async {
  return SessionService().getSession(ref.read(ownerProvider).id!);
});
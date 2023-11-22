import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';

class SessionsNotifier extends StateNotifier<List<Session>> {
  SessionsNotifier() : super([Session()]);
  Future<List<Session>> fetchSessions(int ownerId) async {
    final sessions = await SessionService().getSessions(ownerId);
    state = sessions;
    return sessions;
  }
}

final sessionsProvider = StateNotifierProvider<SessionsNotifier, List<Session>>((ref) {
  return SessionsNotifier();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/team.dart';
import 'package:halisaha_app/services/team_service.dart';

class TeamsNotifier extends StateNotifier<List<Team>> {
  TeamsNotifier() : super([Team()]);
  Future<List<Team>> fetchAllTeams(int playerId) async {
    final teams = await TeamsService().getTeamsIncludePlayer(playerId);
    state = teams;
    return teams;
  }
}

final teamsProvider = StateNotifierProvider<TeamsNotifier, List<Team>>((ref) {
  return TeamsNotifier();
});



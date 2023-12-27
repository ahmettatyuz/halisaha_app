import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/team.dart';

class TeamsNotifier extends StateNotifier<Team?> {
  TeamsNotifier() : super(null);
  Future<Team?> setTakim(Team? team) async {
    state = team;
    return team;
  }
}

final evSahibiProvider = StateNotifierProvider<TeamsNotifier, Team?>((ref) {
  return TeamsNotifier();
});


class RakipNotifier extends StateNotifier<Team?> {
  RakipNotifier() : super(null);
  Future<Team?> setRakipTakim(Team? team) async {
    state = team;
    return team;
  }
}

final deplasmanProvider = StateNotifierProvider<RakipNotifier, Team?>((ref) {
  return RakipNotifier();
});

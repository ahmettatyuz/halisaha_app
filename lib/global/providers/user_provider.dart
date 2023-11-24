import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/models/user.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User());
  User userState(User user) {
    state = user;
    return user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class OwnerNotifier extends StateNotifier<Owner> {
  OwnerNotifier() : super(Owner());
  Owner ownerState(Owner owner) {
    state = owner;
    return owner;
  }
}

final ownerProvider = StateNotifierProvider<OwnerNotifier, Owner>((ref) {
  return OwnerNotifier();
});


class PlayerNotifier extends StateNotifier<Player> {
  PlayerNotifier() : super(Player());
  Player playerState(Player player) {
    state = player;
    return player;
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, Player>((ref) {
  return PlayerNotifier();
});



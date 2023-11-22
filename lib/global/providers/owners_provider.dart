import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/services/owner_service.dart';

class OwnersNotifier extends StateNotifier<List<Owner>> {
  OwnersNotifier() : super([Owner()]);
  Future<List<Owner>> fetchAllOwners() async {
    final owners = await OwnerService().getAllOwners();
    state = owners;
    return owners;
  }
}

final ownersProvider = StateNotifierProvider<OwnersNotifier, List<Owner>>((ref) {
  return OwnersNotifier();
});



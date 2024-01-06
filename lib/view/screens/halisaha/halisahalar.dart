import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/owners_provider.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/view/custom/custom_button.dart.dart';
import 'package:halisaha_app/view/custom/custom_search_bar.dart';
import 'package:halisaha_app/view/widgets/halisaha/halisaha_card.dart';

class Halisahalar extends ConsumerStatefulWidget {
  const Halisahalar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HalisahalarState();
}

class _HalisahalarState extends ConsumerState<Halisahalar> {
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = Center(
      child: Column(
        children: [
          Text(
            "Şehirnde kayıtlı hiç halısaha yok !",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            icon: Icons.refresh,
            buttonText: "Yenile",
            onPressed: () {
              ref.read(ownersProvider.notifier).fetchAllOwners();
            },
          ),
        ],
      ),
    );
    List<Owner> owners = ref.watch(ownersProvider);

    if (owners.isNotEmpty && owners[0].id == null) {
      ref.read(ownersProvider.notifier).fetchAllOwners();
      if (searchText.text != null && searchText.text != "") {
        owners = owners
            .where((element) => element.pitchName!
                .toLowerCase()
                .contains(searchText.text.toLowerCase()))
            .toList();
      }
    }
    for (var element in owners) {
      print(element.pitchName);
    }
    print("owner count : " + owners.length.toString());
    if (owners.isNotEmpty && owners[0].id != null) {
      activeScreen = Column(
        children: [
          CustomSearchBar(
            controller: searchText,
            hint: "Halısaha Ara",
            textChanged: (text) {
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: owners.length,
              itemBuilder: (BuildContext context, int index) {
                return OwnerCard(
                  owner: owners[index],
                );
              },
            ),
          ),
        ],
      );
    }
    return RefreshIndicator(
      child: activeScreen,
      onRefresh: () async {
        ref.read(ownersProvider.notifier).fetchAllOwners();
      },
    );
  }
}

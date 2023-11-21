import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halisaha_app/global/providers/session_provider.dart';
import 'package:halisaha_app/global/providers/user_provider.dart';
import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/services/session_service.dart';
import 'package:halisaha_app/view/widgets/add_session.dart';
import 'package:halisaha_app/view/widgets/session_card.dart';

class SessionEdit extends ConsumerStatefulWidget {
  const SessionEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionEditState();
}

class _SessionEditState extends ConsumerState<SessionEdit> {
  bool state=true;
  void sessionModal() {
    showModalBottomSheet<void>(
      useSafeArea: true,
      context: context,
      builder: (ctx) => AddSession(refresh: refresh,),
    );
  }

  @override
  void initState() {
    super.initState();
  }
  
  void refresh(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(sessionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seanslarım",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: FutureBuilder<List<Session>>(
        future: SessionService().getSession(ref.watch(ownerProvider).id!),
        builder: (context, snapshot) {
          if (state && snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map((e) => SessionCard(time: e.sessionTime!, id: e.id!))
                    .toList(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Hiç seans eklenmemiş !",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: (){
          sessionModal();
        },
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconSize: 35,
          foregroundColor: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/features/voice/data/providers/voice_provider.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';

class VoiceView extends ConsumerStatefulWidget {
  const VoiceView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoiceViewState();
}

class _VoiceViewState extends ConsumerState<VoiceView> {
  // late Timer timer;

  @override
  void initState() {
    super.initState();
    ref.read(voiceViewModelProvider.notifier).connect();

    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   ref.read(voiceRepositoryProvider(5)).printWebRTCStats();
    //   // You can also call an async function here, e.g.:
    //   // fetchData();
    // });
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(voiceViewModelProvider);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: ref
            .read(voiceRepositoryProvider(5))
            .statusStreamController
            .stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Status Nothing");
          final String status = snapshot.data ?? "Status Nothing";
          return Stack(
            children: [
              Positioned(bottom: 0, right: 0, child: Text(status)),
              StreamBuilder(
                stream: ref
                    .read(voiceRepositoryProvider(5))
                    .userStreamController
                    .stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Nothing");
                  }

                  final users = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                    itemCount: users.length,
                    itemBuilder: (context, idx) => Text(users[idx].name),
                  );
                },
              ),
            ],
          );
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

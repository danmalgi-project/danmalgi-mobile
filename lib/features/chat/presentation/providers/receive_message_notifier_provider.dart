// import 'dart:async';

// import 'package:danmalgi_mobile/core/logging/loggable.dart';
// import 'package:danmalgi_mobile/features/auth/domain/auth_state.dart';
// import 'package:danmalgi_mobile/features/auth/presentation/providers/auth_view_model.dart';
// import 'package:danmalgi_mobile/features/chat/data/repositories/chat_repository.dart';
// import 'package:danmalgi_mobile/features/chat/domain/message.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final receiveMessageNotifierProvider =
//     StreamNotifierProvider<ReceiveMessageNotifier, Message>(
//       ReceiveMessageNotifier.new,
//     );

// class ReceiveMessageNotifier extends StreamNotifier<Message> with Loggable {
//   @override
//   Stream<Message> build() {
//     ref.keepAlive();

//     final authState = ref.watch(authViewModelProvider).value;
//     if (authState != null) {
//       if (authState is Authenticated) {
//         logDebug("인증 완료 -> Stream 구독");
//         return ref.read(chatRepositoryProvider).receiveMessage();
//       }
//     }
//     logDebug("인증 실패 -> Stream 해제");

//     ref.onDispose(() {
//       logDebug('ReceiveMessageNotifier dispose');
//     });

//     return Stream.empty();
//   }
// }

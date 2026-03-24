import 'package:danmalgi_mobile/core/generated/direct_message.pb.dart';

class DirectMessageChannelDetailState {
  DirectMessageChannel channel;
  bool isCalling;
  final String? error;

  DirectMessageChannelDetailState({
    required this.channel,
    this.isCalling = false,
    this.error,
  });

  bool get hasError => error != null;

  DirectMessageChannelDetailState copyWith({
    DirectMessageChannel? channel,
    bool? isCalling,
    String? error,
  }) {
    return DirectMessageChannelDetailState(
      channel: channel ?? this.channel,
      isCalling: isCalling ?? this.isCalling,
      error: error ?? this.error,
    );
  }
}

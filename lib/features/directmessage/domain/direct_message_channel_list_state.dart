import 'package:danmalgi_mobile/core/generated/direct_message.pb.dart';

class DirectMessageChannelListState {
  List<DirectMessageChannel> directMessageChannelList = [];
  int currentOffset;
  final String? error;

  DirectMessageChannelListState({
    required this.directMessageChannelList,
    this.currentOffset = 0,
    this.error,
  });

  int get length => directMessageChannelList.length;
  bool get isEmpty => directMessageChannelList.isEmpty;
  bool get isNotEmpty => directMessageChannelList.isNotEmpty;
  bool get hasError => error != null;

  DirectMessageChannelListState copyWith({
    List<DirectMessageChannel>? directMessageChannelList,
    int? currentOffset,
    String? error,
  }) {
    return DirectMessageChannelListState(
      directMessageChannelList:
          directMessageChannelList ?? this.directMessageChannelList,
      currentOffset: currentOffset ?? this.currentOffset,
      error: error ?? this.error,
    );
  }
}

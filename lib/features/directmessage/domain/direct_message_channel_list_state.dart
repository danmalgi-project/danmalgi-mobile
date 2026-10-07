import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'direct_message_channel_list_state.freezed.dart';

@freezed
abstract class DirectMessageChannelListState
    with _$DirectMessageChannelListState {
  const DirectMessageChannelListState._();

  int get length => directMessageChannelList.length;
  bool get isEmpty => directMessageChannelList.isEmpty;
  bool get isNotEmpty => directMessageChannelList.isNotEmpty;
  bool get hasError => error != null;

  const factory DirectMessageChannelListState({
    @Default([]) List<DirectMessageChannelListItem> directMessageChannelList,
    @Default(0) int currentOffset,
    String? error,
  }) = _DirectMessageChannelListState;
}

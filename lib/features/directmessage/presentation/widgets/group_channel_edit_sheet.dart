import 'dart:typed_data';

import 'package:danmalgi_mobile/core/generated/dm/v1/dm.pb.dart';
import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/providers/direct_message_channel_list_view_model.dart';
import 'package:danmalgi_mobile/features/directmessage/presentation/widgets/direct_message_channel_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GroupChannelEditSheet extends ConsumerStatefulWidget {
  final DirectMessageChannel channel;

  const GroupChannelEditSheet({super.key, required this.channel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GroupChannelEditSheetState();
}

class _GroupChannelEditSheetState extends ConsumerState<GroupChannelEditSheet> {
  final TextEditingController _controller = TextEditingController();

  Uint8List? _imageBytes;
  String? _extension;
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? get _newName {
    final name = _controller.text.trim();
    return name.isEmpty || name == widget.channel.channelName ? null : name;
  }

  bool get _canSave => !_saving && (_newName != null || _imageBytes != null);

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 85,
    );
    if (image == null) return;
    final bytes = await image.readAsBytes();
    if (!mounted) return;
    setState(() {
      _imageBytes = bytes;
      _extension = image.name.split('.').last.toLowerCase();
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final result = await ref
        .read(directMessageChannelListViewModelProvider.notifier)
        .updateDirectMessageChannel(
          id: widget.channel.dmId,
          channelName: _newName,
          imageBytes: _imageBytes,
          extension: _extension,
        );
    if (!mounted) return;
    if (result == null) {
      setState(() => _saving = false);
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final myId = ref.watch(currentUserProvider)?.id;
    final imageBytes = _imageBytes;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s24,
        0,
        AppSpacing.s24,
        AppSpacing.s16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.s24,
        children: [
          GestureDetector(
            onTap: _saving ? null : _pickImage,
            child: Stack(
              children: [
                if (imageBytes != null)
                  ClipOval(
                    child: Image.memory(
                      imageBytes,
                      width: AppAvatarSize.lg * 2,
                      height: AppAvatarSize.lg * 2,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  DirectMessageChannelAvatar(
                    channel: widget.channel,
                    myId: myId,
                    radius: AppAvatarSize.lg,
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Material(
                      color: AppColors.accent,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.onAccent,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: _controller,
            enabled: !_saving,
            autocorrect: false,
            enableSuggestions: false,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '그룹 이름 변경하기',
              fillColor: AppColors.surfaceSecondary,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s24,
                vertical: AppSpacing.s12,
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _canSave ? _save : null,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('저장하기'),
            ),
          ),
        ],
      ),
    );
  }
}

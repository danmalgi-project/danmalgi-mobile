import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/widgets/app_bottom_sheet.dart';
import 'package:danmalgi_mobile/features/voice/presentation/providers/voice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showAudioOutputSheet(
  BuildContext context,
  WidgetRef ref,
  int channelId,
) async {
  final notifier = ref.read(
    voiceViewModelProvider(channelId: channelId).notifier,
  );
  final devices = await notifier.getAudioOutputs();
  if (!context.mounted) return;

  showModalBottomSheet(
    context: context,
    // backgroundColor: VoiceColors.surface,
    backgroundColor: Color(0xFF111112),
    builder: (sheetContext) => AppBottomSheet(
      title: '오디오 출력',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final device in devices)
            ListTile(
              leading: const Icon(
                Icons.volume_up,
                color: AppColors.textSecondary,
              ),
              title: Text(
                device.label,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
              onTap: () {
                notifier.selectAudioOutput(device.deviceId);
                Navigator.pop(sheetContext);
              },
            ),
        ],
      ),
    ),
  );
}

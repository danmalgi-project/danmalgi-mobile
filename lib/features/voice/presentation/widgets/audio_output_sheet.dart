import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/widgets/app_bottom_sheet.dart';
import 'package:danmalgi_mobile/features/voice/data/providers/audio_route_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showAudioOutputSheet(
  BuildContext context,
  WidgetRef ref,
  int channelId,
) async {
  final service = ref.read(audioRouteServiceProvider);
  final devices = await service.outputs();
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
                service.select(device.id);
                Navigator.pop(sheetContext);
              },
            ),
        ],
      ),
    ),
  );
}

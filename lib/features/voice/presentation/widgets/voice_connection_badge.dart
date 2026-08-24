import 'package:danmalgi_mobile/features/voice/domain/voice_state.dart';
import 'package:flutter/material.dart';

class VoiceConnectionBadge extends StatelessWidget {
  const VoiceConnectionBadge({super.key, required this.status});
  final VoiceConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      // VoiceConnectionStatus.connecting => ('연결 중', VoiceColors.label),
      // VoiceConnectionStatus.connected => ('연결 양호', VoiceColors.connected),
      // VoiceConnectionStatus.unstable => ('연결 불안정', Colors.orange),
      // VoiceConnectionStatus.failed => ('연결 실패', AppColors.error),
      VoiceConnectionStatus.connecting => ('연결 중', Colors.grey),
      VoiceConnectionStatus.connected => ('연결 양호', Color(0xFF30D158)),
      VoiceConnectionStatus.unstable => ('연결 불안정', Colors.orange),
      VoiceConnectionStatus.failed => ('연결 실패', Colors.red),
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // color: VoiceColors.tile,
        color: Color(0xFF161618),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(label, style: TextStyle(color: color)),
    );
  }
}

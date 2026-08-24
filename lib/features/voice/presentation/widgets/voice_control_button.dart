import 'package:flutter/material.dart';

class VoiceControlButton extends StatelessWidget {
  const VoiceControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    // this.background = VoiceColors.controlButton,
    // this.foreground = AppColors.textMain,
    this.background = const Color(0xFF272729),
    this.foreground = Colors.white,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Material(
        color: background,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Icon(icon, color: foreground, size: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class VoiceControlButton extends StatefulWidget {
  const VoiceControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.background = const Color(0xFF272729),
    this.foreground = Colors.white,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color background;
  final Color foreground;

  @override
  State<VoiceControlButton> createState() => _VoiceControlButtonState();
}

class _VoiceControlButtonState extends State<VoiceControlButton>
    with SingleTickerProviderStateMixin {
  static const _pressedOpacity = 0.2;
  static const _releaseDuration = Duration(milliseconds: 250);

  late final _opacity = AnimationController(vsync: this, value: 1.0);

  void _press() => _opacity.value = _pressedOpacity;
  void _release() =>
      _opacity.animateTo(1.0, duration: _releaseDuration, curve: Curves.linear);

  @override
  void dispose() {
    _opacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    return SizedBox(
      width: 52,
      height: 52,
      child: Material(
        color: widget.background,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTapDown: enabled ? (_) => _press() : null,
          onTapUp: enabled ? (_) => _release() : null,
          onTapCancel: enabled ? _release : null,
          onTap: widget.onTap,
          child: Center(
            child: FadeTransition(
              opacity: _opacity,
              child: Icon(widget.icon, color: widget.foreground, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

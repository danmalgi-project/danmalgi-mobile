import 'package:flutter/material.dart';

class AudioRoutePickerButton extends StatelessWidget {
  const AudioRoutePickerButton({super.key});

  static const _viewType = 'com.danmalgi.mobile/audio_route_picker';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Material(
        color: const Color(0xFF272729),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: const Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: UiKitView(viewType: _viewType),
          ),
        ),
      ),
    );
  }
}

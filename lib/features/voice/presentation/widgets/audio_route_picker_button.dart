import 'package:flutter/material.dart';

class AudioRoutePickerButton extends StatefulWidget {
  final bool enabled;

  const AudioRoutePickerButton({super.key, required this.enabled});

  @override
  State<AudioRoutePickerButton> createState() => _AudioRoutePickerButtonState();
}

class _AudioRoutePickerButtonState extends State<AudioRoutePickerButton> {
  static const _viewType = 'com.danmalgi.mobile/audio_route_picker';

  InteractiveInkFeature? _splash;

  void _startSplash(BuildContext inkContext, PointerDownEvent event) {
    final box = inkContext.findRenderObject()! as RenderBox;
    final theme = Theme.of(context);
    _splash?.confirm();
    late final InteractiveInkFeature splash;
    splash = theme.splashFactory.create(
      controller: Material.of(inkContext),
      referenceBox: box,
      position: box.globalToLocal(event.position),
      color: theme.splashColor,
      textDirection: Directionality.of(context),
      containedInkWell: true,
      customBorder: const CircleBorder(),
      onRemoved: () {
        if (identical(_splash, splash)) _splash = null;
      },
    );
    _splash = splash;
  }

  @override
  void dispose() {
    _splash?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: SizedBox(
        width: 52,
        height: 52,
        child: Material(
          color: const Color(0xFF272729),
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Builder(
            builder: (inkContext) => Listener(
              onPointerDown: (e) => _startSplash(inkContext, e),
              onPointerUp: (_) => _splash?.confirm(),
              onPointerCancel: (_) => _splash?.cancel(),
              child: const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: UiKitView(viewType: _viewType),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

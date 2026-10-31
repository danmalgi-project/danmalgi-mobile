import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AppLifecycleRef on Ref {
  void onAppRestart(VoidCallback callback) {
    final listener = AppLifecycleListener(onRestart: callback);
    onDispose(listener.dispose);
  }
}

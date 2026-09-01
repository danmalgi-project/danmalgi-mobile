import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref, List<ProviderListenable<Object?>> sources) {
    for (final source in sources) {
      ref.listen<Object?>(source, (previous, next) {
        if (_disposed || previous == next) return;
        notifyListeners();
      });
    }
  }

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

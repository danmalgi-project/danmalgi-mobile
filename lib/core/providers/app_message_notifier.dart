import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppMessageNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void show(String message) {
    state = message;
  }
}

final appMessageNotifierProvider = NotifierProvider(AppMessageNotifier.new);

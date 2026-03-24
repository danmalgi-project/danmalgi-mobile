import 'package:danmalgi_mobile/core/providers/app_message_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppMessageWrapper extends ConsumerWidget {
  final Widget child;

  const AppMessageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appMessageNotifierProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), behavior: SnackBarBehavior.floating),
        );
      }
    });

    return child;
  }
}

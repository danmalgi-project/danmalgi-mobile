import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final class ProviderLogger extends ProviderObserver {
  static final _log = Logger('provider');
  static final _lifecycle = Logger('provider.lifecycle');

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    _lifecycle.fine(
      () => '${context.provider.name ?? context.provider.runtimeType} disposed',
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    final name = context.provider.name ?? context.provider.runtimeType;
    final level = error is AppException ? Level.WARNING : Level.SEVERE;
    _log.log(level, '$name 실패', error, stackTrace);
  }
}

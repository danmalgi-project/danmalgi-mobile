import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:danmalgi_mobile/core/error/app_exception.dart';
import 'package:danmalgi_mobile/core/widgets/network_error_view.dart'; // 어제 만든 에러 화면

class AsyncValueHandler<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) builder;
  final VoidCallback onRetry;

  const AsyncValueHandler({
    super.key,
    required this.asyncValue,
    required this.builder,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: builder,

      loading: () => const Center(child: CircularProgressIndicator()),

      error: (error, stack) {
        print(error.runtimeType);
        print(stack);
        if (error is AppException) {
          return error.maybeWhen(
            unauthenticated: (_) => const SizedBox.shrink(),

            network: (msg) => NetworkErrorView(message: msg, onRetry: onRetry),
            timeout: (msg) => NetworkErrorView(message: msg, onRetry: onRetry),

            orElse: () =>
                _DefaultErrorView(error: error.toString(), onRetry: onRetry),
          );
        }

        return _DefaultErrorView(error: '알 수 없는 오류가 발생했습니다.', onRetry: onRetry);
      },
    );
  }
}

class _DefaultErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _DefaultErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          ElevatedButton(onPressed: onRetry, child: const Text('다시 시도')),
        ],
      ),
    );
  }
}

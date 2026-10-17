import 'package:danmalgi_mobile/core/theme/app_colors.dart';
import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:danmalgi_mobile/core/widgets/app_sheet.dart';
import 'package:flutter/material.dart';

class AppSheetAction<T> {
  final T value;
  final String label;
  final bool destructive;

  const AppSheetAction({
    required this.value,
    required this.label,
    this.destructive = false,
  });
}

Future<T?> showAppActionSheet<T>({
  required BuildContext context,
  required List<AppSheetAction<T>> actions,
  String? title,
}) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.scrimStrong,
    elevation: 0,
    builder: (sheetContext) => SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s24,
          0,
          AppSpacing.s24,
          AppSpacing.s12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s12,
          children: [
            _SheetCard(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppSheetHandle(),
                    if (title != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s24,
                        ),
                        child: Text(title, style: AppTypography.title),
                      ),
                    for (final a in actions)
                      _ActionItem(
                        action: a,
                        onTap: () => Navigator.of(sheetContext).pop(a.value),
                      ),
                  ],
                ),
              ),
            ),
            _SheetCard(
              child: InkWell(
                onTap: () => Navigator.of(sheetContext).pop(),
                child: SizedBox(
                  height: 44,
                  child: Center(child: Text('닫기', style: AppTypography.body)),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SheetCard extends StatelessWidget {
  final Widget child;
  const _SheetCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfacePrimary,
      borderRadius: AppRadius.brLg,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _ActionItem<T> extends StatelessWidget {
  final AppSheetAction<T> action;
  final VoidCallback onTap;
  const _ActionItem({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        alignment: Alignment.centerLeft,
        child: Text(
          action.label,
          style: AppTypography.titleSm.copyWith(
            color: action.destructive
                ? AppColors.danger
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

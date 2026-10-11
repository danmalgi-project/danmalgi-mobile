import 'package:danmalgi_mobile/core/theme/app_dimens.dart';
import 'package:danmalgi_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  final List<Widget>? actions;

  final bool padded;

  final bool? resizeToAvoidBottomInset;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.padded = true,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        title: Text(title, style: AppTypography.titleLg),
        titleSpacing: AppSpacing.s20,
        centerTitle: false,
        actions: actions,
        actionsPadding: EdgeInsets.only(right: AppSpacing.s16),
      ),
      body: SafeArea(
        child: padded
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                child: body,
              )
            : body,
      ),
    );
  }
}

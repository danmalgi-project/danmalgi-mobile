import 'package:flutter/material.dart';

class OnboardingMainFrame extends StatelessWidget {
  const OnboardingMainFrame({
    required this.title,
    this.body,
    this.description,
    super.key,
  });

  final String title;
  final String? description;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          if (description != null) ...[
            const SizedBox(height: 12),
            Text(
              description!,
              style: textTheme.bodyLarge?.copyWith(
                color: Color(0xFF8E8E93),
                fontSize: 14,
              ),
            ),
          ],

          const SizedBox(height: 32),

          if (body != null) Expanded(child: body!),
        ],
      ),
    );
  }
}

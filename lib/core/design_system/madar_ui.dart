import 'dart:ui';
import 'package:flutter/material.dart';
import 'madar_theme.dart';

class MadarGlassCard extends StatelessWidget {
  const MadarGlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(20)});
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: .72),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: MadarColors.gold.withValues(alpha: .20)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class MadarSectionTitle extends StatelessWidget {
  const MadarSectionTitle({super.key, required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      if (subtitle != null) ...[
        const SizedBox(height: 6),
        Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ],
  );
}

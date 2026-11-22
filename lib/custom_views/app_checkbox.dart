import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Checkbox with an optional tappable label and subtitle.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.subtitle,
    this.strikeThroughWhenChecked = false,
    this.trailing,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? subtitle;

  /// Cross out the label when checked (useful for to-do items).
  final bool strikeThroughWhenChecked;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final box = Checkbox(
      value: value,
      onChanged: onChanged == null ? null : (v) => onChanged!(v ?? false),
    );
    if (label == null) return box;

    final struck = strikeThroughWhenChecked && value;
    return InkWell(
      borderRadius: AppRadius.field,
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
        child: Row(
          children: [
            box,
            const SizedBox(width: AppSpacing.xxs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label!,
                    style: AppTextStyles.body.copyWith(
                      color: struck
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                      decoration: struck ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (subtitle != null)
                    Text(subtitle!, style: AppTextStyles.caption),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

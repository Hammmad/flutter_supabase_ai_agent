import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_text_field.dart';

/// One option in an [AppDropdown].
class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Filled dropdown that matches [AppTextField].
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.prefixIcon,
    this.errorText,
    this.validator,
    this.enabled = true,
  });

  final List<AppDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final String? errorText;
  final FormFieldValidator<T>? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppFieldLabel(
      label: label,
      child: DropdownButtonFormField<T>(
        // Key on value so external changes to [value] are reflected.
        key: ValueKey(value),
        initialValue: value,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        isExpanded: true,
        style: AppTextStyles.body,
        dropdownColor: AppColors.surface,
        borderRadius: AppRadius.field,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textSecondary,
        ),
        hint: hint == null
            ? null
            : Text(
                hint!,
                style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
              ),
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, size: AppSizes.icon),
        ),
        items: [
          for (final item in items)
            DropdownMenuItem<T>(
              value: item.value,
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    Icon(
                      item.icon,
                      size: AppSizes.icon,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  Flexible(
                    child: Text(item.label, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

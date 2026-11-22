import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppButtonVariant {
  /// Solid emerald. Use at most one per screen.
  primary,

  /// Soft emerald tint. The default for most actions.
  secondary,

  /// Text only, for low-emphasis actions.
  text,

  /// Solid red for destructive actions.
  danger,
}

enum AppButtonSize { medium, small }

/// Pill-shaped button with built-in loading state.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expand = false,
  }) : variant = AppButtonVariant.text;

  const AppButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  }) : variant = AppButtonVariant.danger;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;

  /// Stretch to the full available width.
  final bool expand;

  (Color bg, Color fg, Color pressed) get _colors => switch (variant) {
    AppButtonVariant.primary => (
      AppColors.primary,
      AppColors.onPrimary,
      AppColors.primaryPressed,
    ),
    AppButtonVariant.secondary => (
      AppColors.primarySoft,
      AppColors.onPrimarySoft,
      const Color(0xFFCDEADD),
    ),
    AppButtonVariant.text => (
      Colors.transparent,
      AppColors.primary,
      AppColors.primarySoft,
    ),
    AppButtonVariant.danger => (
      AppColors.error,
      AppColors.onPrimary,
      const Color(0xFF9B2D21),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, pressed) = _colors;
    final height = size == AppButtonSize.small
        ? AppSizes.controlHeightSmall
        : AppSizes.controlHeight;
    final disabled = onPressed == null && !isLoading;

    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(expand ? double.infinity : 0, height),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppRadius.button),
      ),
      elevation: const WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(
        AppTextStyles.button.copyWith(
          fontSize: size == AppButtonSize.small ? 14 : 15,
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((s) {
        if (disabled) {
          return variant == AppButtonVariant.text
              ? Colors.transparent
              : AppColors.disabled;
        }
        if (s.contains(WidgetState.pressed)) return pressed;
        return bg;
      }),
      foregroundColor: WidgetStatePropertyAll(
        disabled ? AppColors.textMuted : fg,
      ),
      overlayColor: WidgetStatePropertyAll(fg.withValues(alpha: 0.06)),
    );

    final child = isLoading
        ? SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSizes.icon),
                const SizedBox(width: AppSpacing.xs),
              ],
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            ],
          );

    return TextButton(
      onPressed: isLoading ? () {} : onPressed,
      style: style,
      child: child,
    );
  }
}

/// Circular icon-only button. Always give it a [tooltip] for accessibility.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.filled = false,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  /// Soft emerald background instead of transparent.
  final bool filled;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      color:
          color ?? (filled ? AppColors.onPrimarySoft : AppColors.textSecondary),
      style: IconButton.styleFrom(
        backgroundColor: filled ? AppColors.primarySoft : Colors.transparent,
        minimumSize: const Size.square(AppSizes.controlHeightSmall),
      ),
    );
  }
}

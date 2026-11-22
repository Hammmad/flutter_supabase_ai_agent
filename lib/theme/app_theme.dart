import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_text_styles.dart';

/// Material theme built from the design tokens, so stock Flutter widgets
/// also match the custom_views components.
abstract final class AppTheme {
  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primarySoft,
      onPrimaryContainer: AppColors.onPrimarySoft,
      secondary: AppColors.primary,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
    );

    const fieldBorder = OutlineInputBorder(
      borderRadius: AppRadius.field,
      borderSide: BorderSide(color: Colors.transparent, width: 1.5),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.heading,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // Fields turn white while focused, as in the approved design.
        fillColor: WidgetStateColor.resolveWith(
          (s) =>
              s.contains(WidgetState.focused) && !s.contains(WidgetState.error)
              ? AppColors.surface
              : AppColors.field,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
        prefixIconColor: WidgetStateColor.resolveWith(
          (s) => s.contains(WidgetState.focused)
              ? AppColors.primary
              : AppColors.textSecondary,
        ),
        suffixIconColor: AppColors.textSecondary,
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        disabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: const BorderSide(color: AppColors.textMuted, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.transparent,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.field),
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.body.copyWith(
          color: AppColors.onPrimary,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

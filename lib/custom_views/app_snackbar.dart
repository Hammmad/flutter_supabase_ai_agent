import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppSnackbarType { info, success, error }

/// Floating snackbar helper.
///
///   AppSnackbar.show(context, 'Saved', type: AppSnackbarType.success);
abstract final class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    AppSnackbarType type = AppSnackbarType.info,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final (bg, icon) = switch (type) {
      AppSnackbarType.info => (AppColors.textPrimary, Icons.info_outline),
      AppSnackbarType.success => (
        AppColors.primary,
        Icons.check_circle_outline,
      ),
      AppSnackbarType.error => (AppColors.error, Icons.error_outline),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bg,
          content: Row(
            children: [
              Icon(icon, color: AppColors.onPrimary, size: AppSizes.icon),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(message)),
            ],
          ),
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  textColor: AppColors.onPrimary,
                  onPressed: onAction ?? () {},
                ),
        ),
      );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, type: AppSnackbarType.success);

  static void error(BuildContext context, String message) =>
      show(context, message, type: AppSnackbarType.error);
}

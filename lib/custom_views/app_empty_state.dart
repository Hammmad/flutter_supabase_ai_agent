import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_button.dart';

/// Icon, headline, short body and an optional action. Also used for errors.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    this.isError = false,
  });

  const AppEmptyState.error({
    super.key,
    this.title = "Something went wrong",
    this.message,
    this.actionLabel = 'Try again',
    this.onAction,
  }) : icon = Icons.error_outline,
       isError = true;

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isError ? AppColors.errorSoft : AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: isError ? AppColors.error : AppColors.primary,
              ),
            ),
            AppSpacing.gapMd,
            Text(
              title,
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(
                message!,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.gapLg,
              AppButton.secondary(
                label: actionLabel!,
                onPressed: onAction,
                expand: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

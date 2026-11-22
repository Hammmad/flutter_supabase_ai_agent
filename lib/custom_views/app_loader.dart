import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Centered spinner with an optional message underneath.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.message, this.size = 32});

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: size,
            child: const CircularProgressIndicator(strokeWidth: 3),
          ),
          if (message != null) ...[
            AppSpacing.gapSm,
            Text(message!, style: AppTextStyles.caption),
          ],
        ],
      ),
    );
  }
}

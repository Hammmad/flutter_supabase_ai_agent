import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Type scale. Two weights only: regular (400) and medium (500).
abstract final class AppTextStyles {
  static const _base = TextStyle(color: AppColors.textPrimary, height: 1.4);

  static final display = _base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );
  static final title = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
  static final heading = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static final body = _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  static final bodyMedium = _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static final label = _base.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static final button = _base.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  static final caption = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextTheme get textTheme => TextTheme(
    displaySmall: display,
    headlineSmall: title,
    titleLarge: heading,
    titleMedium: bodyMedium,
    bodyLarge: body,
    bodyMedium: body,
    labelLarge: button,
    labelMedium: label,
    bodySmall: caption,
  );
}

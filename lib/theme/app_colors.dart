import 'package:flutter/material.dart';

/// Colour tokens for the "Emerald soft" theme.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF0F7A5C);
  static const primaryPressed = Color(0xFF0A5640);
  static const primarySoft = Color(0xFFE3F3EC);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onPrimarySoft = Color(0xFF0A5640);

  // Neutrals
  static const background = Color(0xFFF6F8F7);
  static const surface = Color(0xFFFFFFFF);
  static const field = Color(0xFFEAF0ED);
  static const border = Color(0xFFD6DFDA);
  static const textPrimary = Color(0xFF14201B);
  static const textSecondary = Color(0xFF5B6B64);
  static const textMuted = Color(0xFF8A9993);
  static const disabled = Color(0xFFC9D3CE);

  // Status
  static const error = Color(0xFFC0392B);
  static const errorSoft = Color(0xFFFBEAE8);
  static const success = Color(0xFF1E8E4E);
  static const successSoft = Color(0xFFE6F5EC);
  static const warning = Color(0xFFB7791F);
  static const warningSoft = Color(0xFFFCF3E3);
}

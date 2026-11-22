import 'package:flutter/widgets.dart';

/// Spacing scale (4pt grid).
abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;

  static const gapXs = SizedBox(height: xs, width: xs);
  static const gapSm = SizedBox(height: sm, width: sm);
  static const gapMd = SizedBox(height: md, width: md);
  static const gapLg = SizedBox(height: lg, width: lg);
  static const gapXl = SizedBox(height: xl, width: xl);
}

/// Corner radius tokens.
abstract final class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const pill = 999.0;

  static const field = BorderRadius.all(Radius.circular(md));
  static const card = BorderRadius.all(Radius.circular(lg));
  static const button = BorderRadius.all(Radius.circular(pill));
}

/// Fixed component sizes.
abstract final class AppSizes {
  static const controlHeight = 48.0;
  static const controlHeightSmall = 40.0;
  static const icon = 20.0;
}

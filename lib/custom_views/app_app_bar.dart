import 'package:flutter/material.dart' show AppBar, Divider;
import 'package:flutter/widgets.dart';

import '../theme/app_theme.dart';

/// Flat app bar on the page background, with an optional subtitle.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.showDivider = false,
  });

  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showDivider;

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 60 : 72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      leading: leading,
      titleSpacing: leading == null ? AppSpacing.md : 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) Text(title!, style: AppTextStyles.heading),
          if (subtitle != null) Text(subtitle!, style: AppTextStyles.caption),
        ],
      ),
      actions: [
        ...?actions,
        const SizedBox(width: AppSpacing.xs),
      ],
      bottom: showDivider
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(),
            )
          : null,
    );
  }
}

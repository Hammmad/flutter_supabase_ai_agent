import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

/// Filled text field with an optional label above it.
///
/// Set [obscureText] for passwords; an eye toggle is shown automatically.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
  });

  /// Email field with sensible defaults.
  const AppTextField.email({
    super.key,
    this.controller,
    this.label = 'Email',
    this.hint = 'name@example.com',
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  }) : prefixIcon = Icons.mail_outline,
       suffixIcon = null,
       obscureText = false,
       readOnly = false,
       keyboardType = TextInputType.emailAddress,
       autofillHints = const [AutofillHints.email],
       inputFormatters = null,
       maxLines = 1,
       minLines = null,
       maxLength = null,
       onTap = null;

  /// Password field with a show/hide toggle.
  const AppTextField.password({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction = TextInputAction.done,
    this.autofillHints = const [AutofillHints.password],
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  }) : prefixIcon = Icons.lock_outline,
       suffixIcon = null,
       obscureText = true,
       readOnly = false,
       keyboardType = TextInputType.visiblePassword,
       inputFormatters = null,
       maxLines = 1,
       minLines = null,
       maxLength = null,
       onTap = null;

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    Widget? suffix = widget.suffixIcon;
    if (widget.obscureText) {
      suffix = IconButton(
        tooltip: _obscured ? 'Show password' : 'Hide password',
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: AppSizes.icon,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      );
    }

    return AppFieldLabel(
      label: widget.label,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: _obscured,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        style: AppTextStyles.body,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: widget.hint,
          helperText: widget.helperText,
          helperStyle: AppTextStyles.caption,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(widget.prefixIcon, size: AppSizes.icon),
          suffixIcon: suffix,
          fillColor: widget.enabled
              ? null
              : AppColors.field.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

/// Places a field label above any input. Shared by text fields and dropdowns.
class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel({super.key, required this.child, this.label});

  final String? label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (label == null) return child;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!, style: AppTextStyles.label),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

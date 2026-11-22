import 'package:flutter/material.dart';

import '../custom_views/custom_views.dart';

/// Gallery of every custom_views component, for visual review.
class DesignSystemPage extends StatefulWidget {
  const DesignSystemPage({super.key});

  static Future<void> open(BuildContext context) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => const DesignSystemPage()));

  @override
  State<DesignSystemPage> createState() => _DesignSystemPageState();
}

class _DesignSystemPageState extends State<DesignSystemPage> {
  String? _priority = 'medium';
  bool _checked = true;
  bool _loading = false;

  Future<void> _fakeLoad() async {
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Components',
        subtitle: 'Emerald soft theme',
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _Section('Colors', [
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: const [
                _Swatch('Primary', AppColors.primary),
                _Swatch('Soft', AppColors.primarySoft),
                _Swatch('Field', AppColors.field),
                _Swatch('Text', AppColors.textPrimary),
                _Swatch('Error', AppColors.error),
                _Swatch('Warning', AppColors.warning),
              ],
            ),
          ]),
          _Section('Typography', [
            Text('Display', style: AppTextStyles.display),
            Text('Title', style: AppTextStyles.title),
            Text('Heading', style: AppTextStyles.heading),
            Text(
              'Body text for paragraphs and descriptions.',
              style: AppTextStyles.body,
            ),
            Text('Label', style: AppTextStyles.label),
            Text('Caption', style: AppTextStyles.caption),
          ]),
          _Section('Text fields', [
            const AppTextField.email(),
            AppSpacing.gapMd,
            const AppTextField.password(),
            AppSpacing.gapMd,
            const AppTextField(
              label: 'With error',
              hint: 'Workspace name',
              errorText: "That name's already taken. Try another.",
            ),
            AppSpacing.gapMd,
            const AppTextField(
              label: 'Disabled',
              hint: 'Not editable',
              enabled: false,
            ),
          ]),
          _Section('Dropdown', [
            AppDropdown<String>(
              label: 'Priority',
              value: _priority,
              prefixIcon: Icons.flag_outlined,
              onChanged: (v) => setState(() => _priority = v),
              items: const [
                AppDropdownItem(value: 'low', label: 'Low'),
                AppDropdownItem(value: 'medium', label: 'Medium'),
                AppDropdownItem(value: 'high', label: 'High'),
              ],
            ),
          ]),
          _Section('Buttons', [
            AppButton(
              label: 'Primary',
              isLoading: _loading,
              onPressed: _fakeLoad,
            ),
            AppSpacing.gapSm,
            AppButton.secondary(
              label: 'Secondary',
              icon: Icons.add,
              onPressed: () {},
            ),
            AppSpacing.gapSm,
            AppButton.danger(
              label: 'Delete',
              icon: Icons.delete_outline,
              onPressed: () {},
            ),
            AppSpacing.gapSm,
            const AppButton(label: 'Disabled', onPressed: null),
            AppSpacing.gapSm,
            Wrap(
              spacing: AppSpacing.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                AppButton.text(label: 'Text button', onPressed: () {}),
                AppButton.secondary(
                  label: 'Small',
                  size: AppButtonSize.small,
                  expand: false,
                  onPressed: () {},
                ),
                AppIconButton(
                  icon: Icons.edit_outlined,
                  tooltip: 'Edit',
                  onPressed: () {},
                ),
                AppIconButton(
                  icon: Icons.add,
                  tooltip: 'Add',
                  filled: true,
                  onPressed: () {},
                ),
              ],
            ),
          ]),
          _Section('Checkbox and card', [
            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: AppCheckbox(
                value: _checked,
                label: 'Buy groceries',
                subtitle: 'Strikes through when checked',
                strikeThroughWhenChecked: true,
                onChanged: (v) => setState(() => _checked = v),
              ),
            ),
          ]),
          _Section('Snackbars', [
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                AppButton.secondary(
                  label: 'Info',
                  expand: false,
                  size: AppButtonSize.small,
                  onPressed: () => AppSnackbar.show(context, 'Draft saved'),
                ),
                AppButton.secondary(
                  label: 'Success',
                  expand: false,
                  size: AppButtonSize.small,
                  onPressed: () => AppSnackbar.success(context, 'Todo added'),
                ),
                AppButton.secondary(
                  label: 'Error',
                  expand: false,
                  size: AppButtonSize.small,
                  onPressed: () => AppSnackbar.error(
                    context,
                    "Couldn't connect. Try again.",
                  ),
                ),
              ],
            ),
          ]),
          const _Section('Loader', [
            SizedBox(height: 80, child: AppLoader(message: 'Loading…')),
          ]),
          _Section('Empty state', [
            AppCard(
              child: AppEmptyState(
                icon: Icons.checklist_rounded,
                title: 'Start your first todo',
                message: 'Type above and press enter to add one.',
                actionLabel: 'Add todo',
                onAction: () {},
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title, this.children);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
          ),
          AppSpacing.gapSm,
          ...children,
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.field,
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(name, style: AppTextStyles.caption),
      ],
    );
  }
}

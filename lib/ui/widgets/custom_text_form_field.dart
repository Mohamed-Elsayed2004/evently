import 'package:flutter/material.dart';

typedef Validator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final Validator validator;
  final bool? obscureText;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const CustomTextFormField({
    super.key,
    this.obscureText,
    this.maxLines,
    this.validator,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      cursorColor: theme.colorScheme.primary,
      validator: validator,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,

      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
      ),
    );
  }
}

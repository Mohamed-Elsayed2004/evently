import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? Function(String?)? validator;
  final bool? obscureText;
  final int? maxLines;
  String? hintText;
  String? labelText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  CustomTextFormField({
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
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
      ),
    );
  }
}

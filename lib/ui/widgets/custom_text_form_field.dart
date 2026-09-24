import 'package:flutter/material.dart';

typedef Validator = String? Function(String?)?;
typedef OnChange =void Function(String)?;
class CustomTextFormField extends StatelessWidget {
  final OnChange onChange;
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
    this.suffixIcon, this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      onChanged:onChange ,
      cursorColor: theme.colorScheme.primary,
      validator: validator,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: obscureText == true ? 1 : maxLines,

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

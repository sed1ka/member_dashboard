import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}

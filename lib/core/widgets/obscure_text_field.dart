import 'package:flutter/material.dart';
import 'package:hdi_mini_test/core/constants/app_colors.dart';
import 'package:hdi_mini_test/core/widgets/app_text_field.dart';

class ObscureTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool enabled;

  const ObscureTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.textInputAction,
    this.enabled = true,
  });

  @override
  State<ObscureTextField> createState() => _ObscureTextFieldState();
}

class _ObscureTextFieldState extends State<ObscureTextField> {
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPasswordVisible,
      builder: (context, visible, child) => AppTextField(
        controller: widget.controller,
        labelText: widget.labelText,
        hintText: widget.hintText,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        obscureText: !visible,
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.grey,
          ),
          onPressed: () {
            isPasswordVisible.value = !isPasswordVisible.value;
          },
        ),
      ),
    );
  }
}

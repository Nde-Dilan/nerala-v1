import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:other_screens/common/constants.dart';


class SimpleTextFormField extends StatelessWidget {
  const SimpleTextFormField({
    super.key,
    required this.controller,
    this.scrollController,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.suffix, this.enabled, this.minLines, this.maxLines, this.textInputAction,
  });

  final TextEditingController controller;
  final ScrollController? scrollController;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final Widget prefixIcon;
  final Icon? suffixIcon;
  final Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final Widget? suffix;
  final bool? enabled;
  final int? minLines, maxLines;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: formFieldDecoration,
      child: TextFormField(
        controller: controller,
        scrollController: scrollController,
        enabled: enabled,
        style: AppTextStyles.body,
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        minLines: minLines,
        maxLines: maxLines,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffix: suffix,
          border: AppInputBorders.border,
          focusedBorder: AppInputBorders.focusedBorder,
          errorBorder: AppInputBorders.errorBorder,
          focusedErrorBorder: AppInputBorders.focusedErrorBorder,
          enabledBorder: AppInputBorders.enabledBorder,
          disabledBorder: AppInputBorders.disabledBorder,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
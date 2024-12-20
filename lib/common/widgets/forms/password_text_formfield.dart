import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:other_screens/common/constants.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.obscureText = true,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.onPressed,
  });

  final bool? obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final Function(String)? onChanged;
  final Function()? onPressed;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool? _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: formFieldDecoration,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText!,
        obscuringCharacter: '●',
        style: AppTextStyles.body,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        inputFormatters: widget.inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText!
                  ? HugeIcons.strokeRoundedView
                  : HugeIcons.strokeRoundedViewOffSlash,
              // color: seedColor,
            ),
            onPressed: widget.onPressed ??
                () {
                  setState(() {
                    _obscureText = !_obscureText!;
                  });
                },
          ),
          border: AppInputBorders.border,
          focusedBorder: AppInputBorders.focusedBorder,
          errorBorder: AppInputBorders.errorBorder,
          focusedErrorBorder: AppInputBorders.focusedErrorBorder,
          enabledBorder: AppInputBorders.enabledBorder,
          disabledBorder: AppInputBorders.disabledBorder,
        ),
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: widget.onChanged,
        validator: widget.validator,
      ),
    );
  }
}

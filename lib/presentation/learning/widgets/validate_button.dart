
import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class ValidateButton extends StatelessWidget {
  final bool? isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const ValidateButton({
    super.key,
    this.isEnabled,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(mediaWidth(context) / 0.9, mediaWidth(context) / 6),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBackgroundColor: Colors.grey,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
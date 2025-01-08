import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class ClickToListen extends StatelessWidget {
  final bool? isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const ClickToListen({
    super.key,
    this.isEnabled = true,
    this.onPressed,
    this.text = "Click to listen",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(mediaWidth(context) / 1.9, mediaHeight(context) / 14),
        maximumSize:
            Size(mediaWidth(context) / 2.29, mediaHeight(context) / 14),
        backgroundColor: listenButton,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBackgroundColor: Colors.grey,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: AppTextStyles.h3,
          ),
          const SizedBox(
            width: 10,
          ),
          // Image.asset("assets/icons/question-type/voice.png")
        ],
      ),
    );
  }
}

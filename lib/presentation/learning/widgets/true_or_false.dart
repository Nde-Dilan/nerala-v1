import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class TrueOrFalseWidget extends StatelessWidget {
  const TrueOrFalseWidget(
      {super.key, required this.word, this.wordImage, this.iconImage});

  final String word;
  final String? wordImage;
  final IconData? iconImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: scaffoldBgColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          wordImage != null
              ? (Image.asset(
                  wordImage!,
                  width: mediaWidth(context) * 0.65,
                  height: mediaWidth(context) * 0.65,
                ))
              : (iconImage != null ? (Icon(iconImage)) : Text("")),
          SizedBox(
            height: mediaHeight(context) / 8,
          ),
          Text(
            word,
            style: AppTextStyles.h2,
          )
        ],
      ),
    );
  }
}

Widget trueButton(VoidCallback onPressed) {
  return IconButton(
      onPressed: onPressed,
      icon: Image.asset("assets/icons/question-type/true-false/true.png"));
}

Widget falseButton(VoidCallback onPressed) {
  return IconButton(
      onPressed: onPressed,
      icon: Image.asset("assets/icons/question-type/true-false/false.png"));
}

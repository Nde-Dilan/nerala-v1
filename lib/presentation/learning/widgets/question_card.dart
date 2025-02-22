import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/data/learning/models/question.dart'; 

import 'package:other_screens/presentation/onboarding/widgets/next_button.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Widget child;
  final VoidCallback? onNext;

  const QuestionCard({
    super.key,
    required this.question,
    required this.child,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: scaffoldBgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      borderOnForeground: false,
      child: Column(
        children: [
          child,
          if (onNext != null)
            NextButton(
              onPressed: onNext!,
              isEnabled: true,
            ),
        ],
      ),
    );
  }
}